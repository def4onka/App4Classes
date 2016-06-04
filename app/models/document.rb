class Document < ActiveRecord::Base
  SS = %w{reveal.js dzslides slidy slideous other}
  # FRAGMENT = /<li class="fragment">.*?<\/li>|<div class="fragment">.*?<\/div>/m
  belongs_to :user
  has_many :sections,  dependent: :destroy
  has_many :afiles, dependent: :destroy
  has_many :presentations, dependent: :destroy
  has_many :addons, dependent: :destroy

  validates :way, inclusion: {in: 0...SS.size}

  def create_sections_and_afiles(file)
    Zip::File.open(file) do |zip_file|
      zip_file.each do |entry|
        next unless entry.ftype == :file
          if entry.name == 'index.html'
            index = 0
            doc = Nokogiri::HTML(entry.get_input_stream.read)
            case self.way
            when 0 #reveal
              doc.css('section').remove.css('section').reverse.each do |b|
                if b['class']
                  b['class'] = b['class'] << " present"
                else
                  b['class'] = "present"
                end
                  self.sections << Section.new(source: b, position: index)
                  index += 1
                end
                  doc.css('link, style').each do |addon|
                    unless /#{addon['href']}/ =~ "^(http|https)://"
                      addon['href'] = addon['href'].to_s.gsub(/\//,'_')
                    end
                    self.addons << Addon.new(source: addon)
                  end
            when 1 #dzslides
              doc.css('section').remove.css('section').reverse.each do |b|
                b['aria-selected'] = "true"
                  self.sections << Section.new(source: b, position: index)
                  index += 1
                end
                  doc.css('link, style').each do |addon|
                    unless /#{addon['href']}/ =~ "^(http|https)://"
                      addon['href'] = addon['href'].to_s.gsub(/\//,'_')
                    end
                    self.addons << Addon.new(source: addon)
                  end
            end
            # if (0..1).include? self.way
            #   doc.css('section').remove.css('section').each do |b|
            #     self.sections << Section.new(source: b, position: index)
            #     index += 1
            #   end
            #   doc.css('link, style').each do |addon|
            #     unless addon['src,href'] =~ "^(http|https)://"
            #       addon['src,href'].to_s.gsub(/\//,'_')
            #     end
            #     self.addons << Addon.new(source: addon)
            #   end
            # end
            # if (2..3).include? self.way
            #   doc.css('div.slide').reverse.each do |b|
            #     self.sections << Section.new(source: b, position: index)
            #     index += 1
            #   end
            #   doc.css('link, style, script').each do |addon|
            #     unless addon['src,href'] =~ "^(http|https)://"
            #       addon['src,href'].to_s.gsub(/\//,'_')
            #     end
            #     self.addons << Addon.new(source: addon)
            #   end
            # end

          else
            self.afiles << Afile.create(source: entry.get_input_stream.read,
                                   path: entry.name.gsub(/\//,'_')) #заменить / на _
          end
      end
    end
  end

end
