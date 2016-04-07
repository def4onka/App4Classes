class Document < ActiveRecord::Base
  belongs_to :user
  has_many :sections,  dependent: :destroy
  has_many :afiles, dependent: :destroy
  has_many :presentations

  FRAGMENT = /<li class="fragment">.*?<\/li>|<div class="fragment">.*?<\/div>/m

  def create_sections_and_afiles(file)
    Zip::File.open(file) do |zip_file|
      zip_file.each do |entry|
        next unless entry.ftype == :file
        if entry.name == 'index.html'
          # index = 0
          # entry.get_input_stream.read.split('</section>').map do |p|
          #   puts "\naaaaaaaaaaaaaa#{p}\n"
          #   p.sub(/.*<section[^>]*>/m,'')
          # end.each do |body|
          #   next if body.blank? || body =~ /edu.mephi.ru\/reveal.js/
          #   if body =~ /class="author">.*?(<script.*)<\/h2>/m
          #       body = body.sub($1, '')
          #   end
          #   buf = [body]
          #   while buf.last =~ FRAGMENT
          #     buf << buf.last.gsub(/(.*)(#{FRAGMENT})(.*)/m, '\1\3')
          #   end
          #   buf.reverse.each do |b|
          #     self.sections << Section.new(source: b, position: index)
          #     index += 1
          #   end
          # end
        else
          self.afiles << Afile.create(source: entry.get_input_stream.read,
                                 path: entry.name.gsub(/\//,'_'))
        end
      end
    end
  end
end
