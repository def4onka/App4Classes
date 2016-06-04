# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('section.computer').draggable containment: 'parent'
  $('section.computer').draggable
    stop: (e) ->
      alert this.id
      $.ajax
        # url: window.location.pathname,
        url: "/machines/"+this.id
        type: 'patch',
        dataType: 'json',
        data:
          left: e.pageX,
          top: e.pageY
      return
  #
  # comps = document.querySelectorAll('.computer')
  # dragSrcEl = null
  # handleDragStart = (e) ->
  #   @style.opacity = '0.4'
  #       # this / e.target is the source node.
  #   dragSrcEl = this
  #   e.dataTransfer.effectAllowed = 'move'
  #   return
  #
  # handleDragOver = (e) ->
  #   if e.preventDefault
  #     e.preventDefault()
  #     # Necessary. Allows us to drop.
  #   e.dataTransfer.dropEffect = 'move'
  #
  #   # See the section on the DataTransfer object.
  #   false
  #
  # handleDragEnter = (e) ->
  #   # this / e.target is the current hover target.
  #   @classList.add 'over'
  #   return
  #
  # handleDragLeave = (e) ->
  #   @classList.remove 'over'
  #   # this / e.target is previous target element.
  #   return
  #
  # handleDrop = (e) ->
  #   # this / e.target is current target element.
  #   if e.stopPropagation
  #     e.stopPropagation()
  #     # stops the browser from redirecting.
  #   # See the section on the DataTransfer object.
  #   if dragSrcEl != this
  #   # Set the source column's HTML to the HTML of the column we dropped on.
  #     dragSrcEl.style.backgroundColor = 'plum'
  #     # @innerHTML = e.dataTransfer.getData('text/html')
  #   false
  #
  # handleDragEnd = (e) ->
  #   # this/e.target is the source node.
  #   [].forEach.call comps, (comp) ->
  #     comp.classList.remove 'over'
  #     return
  #   if dragSrcEl != this
  #   # Set the source column's HTML to the HTML of the column we dropped on.
  #     dragSrcEl.style.backgroundColor = 'plum'
  #
  #   return
  #
  #
  # @classList = [].forEach.call comps, (comp) ->
  #   comp.addEventListener 'dragstart', handleDragStart, false
  #   comp.addEventListener 'dragenter', handleDragEnter, false
  #   comp.addEventListener 'dragover', handleDragOver, false
  #   comp.addEventListener 'dragleave', handleDragLeave, false
  #   comp.addEventListener 'drop', handleDrop, false
  #   comp.addEventListener 'dragend', handleDragEnd, false
  #   return


















# func = ->
#   DragManager = new (->
#
#     ###*
#     # составной объект для хранения информации о переносе:
#     # {
#     #   elem - элемент, на котором была зажата мышь
#     #   avatar - аватар
#     #   downX/downY - координаты, на которых был mousedown
#     #   shiftX/shiftY - относительный сдвиг курсора от угла элемента
#     # }
#     ###
#
#     dragObject = {}
#     self = this
#
#     onMouseDown = (e) ->
#       if e.which != 1
#         return
#       elem = e.target.closest('.draggable')
#       if !elem
#         return
#       dragObject.elem = elem
#       # запомним, что элемент нажат на текущих координатах pageX/pageY
#       dragObject.downX = e.pageX
#       dragObject.downY = e.pageY
#       false
#
#     onMouseMove = (e) ->
#       if !dragObject.elem
#         return
#       # элемент не зажат
#       if !dragObject.avatar
#         # если перенос не начат...
#         moveX = e.pageX - (dragObject.downX)
#         moveY = e.pageY - (dragObject.downY)
#         # если мышь передвинулась в нажатом состоянии недостаточно далеко
#         if Math.abs(moveX) < 3 and Math.abs(moveY) < 3
#           return
#         # начинаем перенос
#         dragObject.avatar = createAvatar(e)
#         # создать аватар
#         if !dragObject.avatar
#           # отмена переноса, нельзя "захватить" за эту часть элемента
#           dragObject = {}
#           return
#         # аватар создан успешно
#         # создать вспомогательные свойства shiftX/shiftY
#         coords = getCoords(dragObject.avatar)
#         dragObject.shiftX = dragObject.downX - (coords.left)
#         dragObject.shiftY = dragObject.downY - (coords.top)
#         startDrag e
#         # отобразить начало переноса
#       # отобразить перенос объекта при каждом движении мыши
#       dragObject.avatar.style.left = e.pageX - (dragObject.shiftX) + 'px'
#       dragObject.avatar.style.top = e.pageY - (dragObject.shiftY) + 'px'
#       false
#
#     onMouseUp = (e) ->
#       if dragObject.avatar
#         # если перенос идет
#         finishDrag e
#       # перенос либо не начинался, либо завершился
#       # в любом случае очистим "состояние переноса" dragObject
#       dragObject = {}
#       return
#
#     finishDrag = (e) ->
#       dropElem = findDroppable(e)
#       if !dropElem
#         # m_id = dragObject.closest('draggable').find('section.draggable').attr id
#         # alert dragObject.closest('draggable').find('section.draggable').attr id
#         self.onDragCancel dragObject
#         # $.ajax
#         #   # url: window.location.pathname,
#         #   url: "machines/"+id
#         #   type: post,
#         #   dataType: 'json',
#         #   data:
#         #     id:
#         #     left: dragObject.style.left,
#         #     top: dragObject.style.top
#       else
#         self.onDragEnd dragObject, dropElem
#       return
#
#     createAvatar = (e) ->
#       # запомнить старые свойства, чтобы вернуться к ним при отмене переноса
#       avatar = dragObject.elem
#       old =
#         parent: avatar.parentNode
#         nextSibling: avatar.nextSibling
#         position: avatar.position or ''
#         left: avatar.left or ''
#         top: avatar.top or ''
#         zIndex: avatar.zIndex or ''
#       # функция для отмены переноса
#
#       avatar.rollback = ->
#         old.parent.insertBefore avatar, old.nextSibling
#         avatar.style.position = old.position
#         avatar.style.left = old.left
#         avatar.style.top = old.top
#         avatar.style.zIndex = old.zIndex
#         return
#
#       avatar
#
#     startDrag = (e) ->
#       avatar = dragObject.avatar
#       # инициировать начало переноса
#       document.body.appendChild avatar
#       avatar.style.zIndex = 9999
#       avatar.style.position = 'absolute'
#       return
#
#     findDroppable = (event) ->
#       # спрячем переносимый элемент
#       dragObject.avatar.hidden = true
#       # получить самый вложенный элемент под курсором мыши
#       elem = document.elementFromPoint(event.clientX, event.clientY)
#       # показать переносимый элемент обратно
#       dragObject.avatar.hidden = false
#       if elem == null
#         # такое возможно, если курсор мыши "вылетел" за границу окна
#         return null
#       elem.closest '.droppable'
#
#     document.onmousemove = onMouseMove
#     document.onmouseup = onMouseUp
#     document.onmousedown = onMouseDown
#
#     @onDragEnd = (dragObject, dropElem) ->
#
#     @onDragCancel = (dragObject) ->
#
#     return
#   )
#
#   getCoords = (elem) ->
#     # кроме IE8-
#     box = elem.getBoundingClientRect()
#     {
#       top: box.top + pageYOffset
#       left: box.left + pageXOffset
#     }
#
# $(document).ready func
