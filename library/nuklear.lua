---@meta

local nuklear = {}

---Windows and some window-like widgets can accept a number of window flags.
---Either specify the window flags separately as function arguments or bundle
---them all in a single table.
---@alias nuklear.flags
---| "border" # Draw a border around the window.
---| "movable" # The window can be moved by dragging the header.
---| "scalable" # The window can be scaled by dragging the corner.
---| "closable" # The window can be closed by clicking the close button.
---| "minimizable" # The window can be collapsed by clicking the minimize button.
---| "scrollbar" # Include a scrollbar for the window.
---| "title" # Display the window title on the header.
---| "scroll auto hide" # Automatically hide the scrollbar after a period of inactivity.
---| "background" # Keep the window behind all other windows.

---An instance of the Nuklear library.
---@class nuklear.ui
local ui = {}

---Any function that accepts a LÖVE Image as an argument also accepts a LÖVE
---Canvas. You can also specify a LÖVE Quad to use by passing a two-item array
---`{Image, Quad}` or `{Canvas, Quad}`, where `Quad` specifies which part of
---the image to draw.
---@alias nuklear.image love.Image | love.Canvas | { [1]: love.Image, [2]: love.Quad } | { [1]: love.Canvas, [2]: love.Quad }

---Various widgets accept symbol type strings as parameters.
---@alias nuklear.symbol
---| 'none'
---| 'x'
---| 'underscore'
---| 'circle solid'
---| 'circle outline'
---| 'rect solid'
---| 'rect outline'
---| 'triangle up'
---| 'triangle down'
---| 'triangle left'
---| 'triangle right'
---| 'plus'
---| 'minus'

---Some widgets accept alignment arguments for text, symbols, and/or images.
---@alias nuklear.alignment
---| 'left'
---| 'centered'
---| 'right'
---| 'top left'
---| 'top centered'
---| 'top right'
---| 'bottom left'
---| 'bottom centered'
---| 'bottom right'

---Some styles and widgets accept a "color string" parameter. This is a string
---of the format '#RRGGBB' or '#RRGGBBAA', where RR, GG, BB, and AA are each a
---byte in hexadecimal.
---@alias nuklear.color string

---Initialize a new instance of the library. This must be called before any of
---the other functions.
---
---Events:
--- - `ui:keypressed(key, scancode, isrepeat)`
--- - `ui:keyreleased(key, scancode)`
--- - `ui:mousepressed(x, y, button, istouch, presses)`
--- - `ui:mousereleased(x, y, button, istouch, presses)`
--- - `ui:mousemoved(x, y, dx, dy, istouch)`
--- - `ui:textinput(text)`
--- - `ui:wheelmoved(x, y)`
---@return nuklear.ui
function nuklear.newUI() end

--#region # Event

---Pass the given key press event to the UI
---@param key love.KeyConstant
---@param scancode love.Scancode
---@param isrepeat boolean
---@return boolean consumed -- `true` if the event is consumed and `false` otherwise.
function ui:keypressed(key, scancode, isrepeat) end

---Pass the given key release event to the UI
---@param key love.KeyConstant
---@param scancode love.Scancode
---@return boolean consumed -- `true` if the event is consumed and `false` otherwise.
function ui:keyreleased(key, scancode) end

---Pass the given mouse press event to the UI
---@param x number
---@param y number
---@param button number
---@param istouch boolean
---@param presses number
---@return boolean consumed -- `true` if the event is consumed and `false` otherwise.
function ui:mousepressed(x, y, button, istouch, presses) end

---Pass the given mouse release event to the UI
---@param x number
---@param y number
---@param button number
---@param istouch boolean
---@param presses number
---@return boolean consumed -- `true` if the event is consumed and `false` otherwise.
function ui:mousereleased(x, y, button, istouch, presses) end

---Pass the given mouse move event to the UI
---@param x number
---@param y number
---@param dx number
---@param dy number
---@param istouch boolean
---@return boolean consumed -- `true` if the event is consumed and `false` otherwise.
function ui:mousemoved(x, y, dx, dy, istouch) end

---Pass the given text input event to the UI
---@param text string
---@return boolean consumed -- `true` if the event is consumed and `false` otherwise.
function ui:textinput(text) end

---Pass the given wheel move event to the UI
---@param x number
---@param y number
---@return boolean consumed -- `true` if the event was consumed and `false` otherwise
function ui:wheelmoved(x, y) end

--#endregion

--#region # Render

---Draw the UI. Call this once every `love.draw`.
function ui:draw() end

--#endregion

--#region # Update

---Begin a new frame for the UI. Call this once every `love.update`, before
---other UI calls.
function ui:frameBegin() end

---End the current frame. Call this once every `love.update`, after other UI
---calls.
function ui:frameEnd() end

---Equivalent to:
---
---```lua
---ui:frameBegin()
---body(ui)
---ui:frameEnd()
---```
---@param body fun(ui: nuklear.ui)
function ui:frame(body) end

--#endregion

--#region # Transform

---Rotate the UI by `angle` (in radians).
---
---All transform functions must be called after `ui:frameBegin` and before any
---non-transform functions.
---@param angle number
function ui:rotate(angle) end

---Scale the UI by `scale` in both X and Y directions, or specify `scaleX` and
---`scaleY` separately.
---@param scaleX number
---@param scaleY number
---@overload fun(self: nuklear.ui, scale: number)
function ui:scale(scaleX, scaleY) end

---Shear the UI by `shearX` in the X direction and `shearY` in the Y direction.
---@param shearX number
---@param shearY number
function ui:shear(shearX, shearY) end

---Translate the UI by `dx` in the X direction and `dy` in the Y direction.
---@param dx number
---@param dy number
function ui:translate(dx, dy) end

--#endregion

--#region # Window

---Create or update a window with the given `name`. The `name` is a unique
---identifier used internally to differentiate between windows. If unspecified,
---the `name` defaults to the `title`. The `x`, `y`, `width`, and `height`
---parameters describe the window's initial bounds. All additional arguments
---are interpreted as window flags.
---@param name string
---@param title string
---@param x number
---@param y number
---@param width number
---@param height number
---@param ... nuklear.flags|nuklear.flags[]
---@return boolean open -- `true` if the window is open and `false` if it is closed or collapsed.
---@overload fun(self: nuklear.ui, title: string, x: number, y: number, width: number, height: number, ...: nuklear.flags|nuklear.flags[]): (open: boolean)
function ui:windowBegin(name, title, x, y, width, height, ...) end

---End a window. This must always be called after `ui:windowBegin`, regardless
---of whether or not the window is open.
function ui:windowEnd() end

---Equivalent to:
---
---```lua
---if ui:windowBegin(...) then
---  body(ui)
---end
---ui:windowEnd()
---```
---@param name string
---@param title string
---@param x number
---@param y number
---@param width number
---@param height number
---@param ... nuklear.flags|fun(ui: nuklear.ui) -- `body` *must* be the last argument.
---@overload fun(self: nuklear.ui, name: string, title: string, x: number, y: number, width: number, height: number, flags: nuklear.flags[], body: fun(ui: nuklear.ui))
---@overload fun(self: nuklear.ui, title: string, x: number, y: number, width: number, height: number, ...: nuklear.flags|nuklear.flags[]|fun(ui: nuklear.ui))
---@overload fun(self: nuklear.ui, title: string, x: number, y: number, width: number, height: number, flags: nuklear.flags[], body: fun(ui: nuklear.ui))
function ui:window(name, title, x, y, width, height, ...) end

---Return the bounds of the current window.
---@return number x, number y, number width, number height
---@nodiscard
function ui:windowGetBounds() end

---Return the position of the current window.
---@return number x, number y
---@nodiscard
function ui:windowGetPosition() end

---Return the size of the current window.
---@return number width, number height
---@nodiscard
function ui:windowGetSize() end

---Return the bounds of the current window's content region.
---@return number x, number y, number width, number height
---@nodiscard
function ui:windowGetContentRegion() end

---Return `true` if the current window is focused, and `false` otherwise.
---@return boolean focused
---@nodiscard
function ui:windowHasFocus() end

---Get the scroll position (`sx`, `sy`) of the current window.
---@return number sx, number sy
---@nodiscard
function ui:windowGetScroll() end

---Set the scroll position (`sx`, `sy`) of the current window.
---@param sx number
---@param sy number
function ui:windowSetScroll(sx, sy) end

---Return `true` if the given window is collapsed, and `false` otherwise.
---@param name string
---@return boolean collapsed
---@nodiscard
function ui:windowIsCollapsed(name) end

---Return `true` if the given window was closed using `ui:windowClose`, and
---`false` otherwise.
---@param name string
---@return boolean closed
---@nodiscard
function ui:windowIsClosed(name) end

---Return `true` if the given window is hidden, and `false` otherwise.
---@param name string
---@return boolean hidden
---@nodiscard
function ui:windowIsHidden(name) end

---Return `true` if the given window is active, and `false` otherwise.
---@param name string
---@return boolean active
---@nodiscard
function ui:windowIsActive(name) end

---Return `true` if the current window is hovered by the mouse, and `false`
---otherwise.
---@return boolean hovered
---@nodiscard
function ui:windowIsHovered() end

---Return `true` if any window is hovered by the mouse, and `false` otherwise.
---@return boolean hovered
---@nodiscard
function ui:windowIsAnyHovered() end

---Return `true` if any item is active, and `false` otherwise.
---@return boolean active
---@nodiscard
function ui:itemIsAnyActive() end

---Set the bounds of the given window.
---@param name string
---@param x number
---@param y number
---@param width number
---@param height number
function ui:windowSetBounds(name, x, y, width, height) end

---Set the position of the given window.
---@param name string
---@param x number
---@param y number
function ui:windowSetPosition(name, x, y) end

---Set the size of the given window.
---@param name string
---@param width number
---@param height number
function ui:windowSetSize(name, width, height) end

---Focus on the given window.
---@param name string
function ui:windowSetFocus(name) end

---Close the given window.
---@param name string
function ui:windowClose(name) end

---Collapse the given window.
---@param name string
function ui:windowCollapse(name) end

---Expand the given window.
---@param name string
function ui:windowExpand(name) end

---Show the given window.
---@param name string
function ui:windowShow(name) end

---Hide the given window.
---@param name string
function ui:windowHide(name) end

--#endregion

--#region # Layout

---Adopt a row layout for the proceeding widgets.
---
---If the `layout` is `'dynamic'`, the row height and columns must be
---specified. If `cols` is a number, it specifies the number of equally sized
---columns to divide the row into. If there is a `ratios` table instead, the
---table is treated as an array of ratios from 0 to 1. Each ratio describes the
---width of the column with respect to the total row width.
---
---If the `layout` is `'static'`, there must either be `itemWidth` and `cols`
---parameters describing the number of fixed-width columns to divide the row
---into, or there must be a `sizes` table, which is an array of fixed widths
---for the columns.
---
---Examples:
---
---```lua
----- Create a row which is 30 pixels high and is divided into 3 equally sized columns.
---ui:layoutRow('dynamic', 30, 3)
---
----- Create a row which is 25 pixels high and divided into two columns with a size ratio of 1:3.
---ui:layoutRow('dynamic', 25, {0.25, 0.75})
---
----- Create a row which is 120 pixels high and is divided into 3 columns, each of width 20.
---ui:layoutRow('static', 120, 20, 3)
---
----- Create a row which is 40 pixels high and is divided into two columns, one 20 pixels wide and the other 30 pixels.
---ui:layoutRow('static', 40, {20, 30})
---```
---
---@param layout 'dynamic'
---@param height number
---@param cols integer
---@overload fun(self: nuklear.ui, layout: 'dynamic', height: number, ratios: number[])
---@overload fun(self: nuklear.ui, layout: 'static', height: number, itemWidth: number, cols: number)
---@overload fun(self: nuklear.ui, layout: 'static', height: number, sizes: number[])
function ui:layoutRow(layout, height, cols) end

---Adopt a row layout of the specified format type, height, and column count.
---Before each proceeding widget, call `ui:layoutRowPush` to set the column
---size. Don't forget to end the layout with `ui:layoutRowEnd`.
---@param layout 'dynamic' | 'static'
---@param height number
---@param cols number
function ui:layoutRowBegin(layout, height, cols) end

---Specify the width of the next widget in a row layout started with
---`ui:layoutRowBegin`. If the layout is dynamic, the width is specified as a
---ratio of the total row width from 0 to 1. If the layout is static, the width
---is specified as a number of pixels.
---@param ratio number
---@overload fun(self: nuklear.ui, size: number)
function ui:layoutRowPush(ratio) end

---Call after `ui:layoutRowBegin` in order to properly end the row layout.
function ui:layoutRowEnd() end

---Equivalent to:
---
---```lua
---ui:layoutRowBegin(...)
---body(ui)
---ui:layoutRowEnd()
---```
---@param layout 'dynamic' | 'static'
---@param height number
---@param cols number
---@param body fun(ui: nuklear.ui)
function ui:layoutRow(layout, height, cols, body) end

---Start a template layout with the given `height`. Make all of your
---`ui:layoutTemplatePush` and `ui:layoutTemplateEnd` calls before the widgets
---to be laid out. Template layouts repeat row-by-row until another layout is
---instituted.
---
---Example:
---
---```lua
---ui:layoutTemplateBegin(100)
---ui:layoutTemplatePush('static', 25)
---ui:layoutTemplatePush('dynamic')
---ui:layoutTemplatePush('variable', 25)
---ui:layoutTemplateEnd()
---ui:button(nil, '#ff0000') -- This button will always be 25 pixels wide.
---ui:button(nil, '#00ff00') -- This button will grow to fit space and shrink to zero without space.
---ui:button(nil, '#0000ff') -- This button will grow to fit space and shrink to a minimum of 25 pixels without space.
---```
---@param height number
function ui:layoutTemplateBegin(height) end

---Pushes a column onto a template layout. If the column is `'dynamic'`, it
---grows to fit space and shrinks to zero width when there is no room. If the
---column is `'variable'`, it grows to fit space and shrinks to a minimum of
---`width` pixels when there is no room. If the column is `'static'`, it stays
---at a constant `width` pixels. Remember to push all of your template columns
---and then call `ui:layoutTemplateEnd` before creating your widgets.
---@param layout 'variable' | 'static'
---@param width number
---@overload fun(self: nuklear.ui, layout: 'dynamic')
function ui:layoutTemplatePush(layout, width) end

---End a template layout declaration. Remember to call this before creating
---your widgets.
function ui:layoutTemplateEnd() end

---Equivalent to:
---
---```lua
---ui:layoutTemplateBegin(height)
---body(ui)
---ui:layoutTemplateEnd()
---```
---@param height number
---@param body fun(ui: nuklear.ui)
function ui:layoutTemplate(height, body) end

---Start a space layout with the given height and widget count. Call
---`ui:layoutSpacePush` before each proceeding widget and `ui:layoutSpaceEnd`
---after the layout is finished.
---@param layout 'dynamic' | 'static'
---@param height number
---@param widgetCount integer
function ui:layoutSpaceBegin(layout, height, widgetCount) end

---Specify the bounds of a widget in a space layout. If the layout is dynamic,
---the bounds are specified as ratios from 0 to 1 of the total width and height
---of the space layout. If the layout is static, the bounds are pixel valued
---offsets from the beginning of the layout.
---@param x number
---@param y number
---@param width number
---@param height number
function ui:layoutSpacePush(x, y, width, height) end

---End a space layout.
function ui:layoutSpaceEnd() end

---Equivalent to:
---
---```lua
---ui:layoutSpaceBegin(...)
---body(ui)
---ui:layoutSpaceEnd()
---```
---@param layout 'dynamic' | 'static'
---@param height number
---@param widgetCount integer
---@param body fun(ui: nuklear.ui)
function ui:layoutSpace(layout, height, widgetCount, body) end

---Return the bounds of the current space layout.
---@return number x, number y, number width, number height
---@nodiscard
function ui:layoutSpaceBounds() end

---Convert a space layout local position to global screen position.
---@param x number
---@param y number
---@return number x, number y
---@nodiscard
function ui:layoutSpaceToScreen(x, y) end

---Convert a global screen position to space layout local position.
---@param x number
---@param y number
---@return number x, number y
---@nodiscard
function ui:layoutSpaceToLocal(x, y) end

---Convert space layout local bounds to global screen bounds.
---@param x number
---@param y number
---@param width number
---@param height number
---@return number x, number y, number width, number height
---@nodiscard
function ui:layoutSpaceRectToScreen(x, y, width, height) end

---Convert global screen bounds to space layout local bounds.
---@param x number
---@param y number
---@param width number
---@param height number
---@return number x, number y, number width, number height
---@nodiscard
function ui:layoutSpaceRectToLocal(x, y, width, height) end

---Convert a pixel width to a ratio suitable for a dynamic layout.
---@param pixelWidth number
---@return number ratio
---@nodiscard
function ui:layoutRatioFromPixel(pixelWidth) end

--#endregion

--#region # Widgets
--#region ## Groups

---Start a group. Groups can have titles and scrollbars just like windows.
---
---Call `ui:groupEnd` at the end of a group if it's open.
---@param title string
---@param ... nuklear.flags|nuklear.flags[]
---@return boolean open -- `true` if the group is open and `false` otherwise.
function ui:groupBegin(title, ...) end

---End a group. Remember to call this whenever the group is open.
function ui:groupEnd() end

---Equivalent to:
---
---```lua
---ui:groupBegin(...)
---body(ui)
---ui:groupEnd()
---```
---
---@param title string
---@param ... nuklear.flags|nuklear.flags[]|fun(ui: nuklear.ui) -- `body` *must* be the last argument.
function ui:group(title, ...) end

---Get the scroll position (`sx`, `sy`) of the group with the given `title`.
---@param title string
---@return number sx, number sy
---@nodiscard
function ui:groupGetScroll(title) end

---Set the scroll position (`sx`, `sy`) of the group with the given `title`.
---@param title string
---@param sx number
---@param sy number
function ui:groupSetScroll(title, sx, sy) end

--#endregion
--#region ## Trees

---Start a tree. The resulting item is either a `'node'` or a `'tab'`, with the
---idea being that nodes are a level below tabs.
---
---Remember to call `ui:treePop` if the item is open.
---@param item 'node' | 'tab'
---@param title string
---@return boolean open -- `true` if the item is expanded and `false` if it is collapsed.
---@overload fun(self: nuklear.ui, item: 'node' | 'tab', title: string, image: nuklear.image): (open: boolean)
---@overload fun(self: nuklear.ui, item: 'node' | 'tab', title: string, image: nuklear.image, startingState: 'collapsed' | 'expanded'): (open: boolean)
function ui:treePush(item, title) end

---Ends a tree. Call this at the end of an open tree item.
function ui:treePop() end

---Equivalent to:
---
---```lua
---if ui:treePush(...) then
---  body(ui)
---  ui:treePop()
---end
---```
---@param item 'node' | 'tab'
---@param title string
---@param body fun(ui: nuklear.ui)
---@overload fun(self: nuklear.ui, item: 'node' | 'tab', title: string, image: nuklear.image, body: fun(ui: nuklear.ui))
---@overload fun(self: nuklear.ui, item: 'node' | 'tab', title: string, image: nuklear.image, startingState: 'collapsed' | 'expanded', body: fun(ui: nuklear.ui))
function ui:tree(item, title, body) end

---Same as `ui:treePush`, but the `startingState` argument sets the current
---state of the tree instead of just specifying the initial state.
---
---Be sure to call `ui:treeStatePop` if the tree is open.
---@param item 'node' | 'tab'
---@param title string
---@return boolean open -- `true` if the item is expanded and `false` if it is collapsed.
---@overload fun(self: nuklear.ui, item: 'node' | 'tab', title: string, image: nuklear.image)
---@overload fun(self: nuklear.ui, item: 'node' | 'tab', title: string, image: nuklear.image, state: 'collapsed' | 'expanded')
function ui:treeStatePush(item, title) end

---Ends an open tree started with `ui:treeStatePush`. Call this at the end of
---every open treeState.
function ui:treeStatePop() end

---Equivalent to:
---
---```lua
---if ui:treeStatePush(...) then
---  body(ui)
---  ui:treeStatePop()
---end
---```
---@param item 'node' | 'tab'
---@param title string
---@param body fun(ui: nuklear.ui)
---@overload fun(self: nuklear.ui, item: 'node' | 'tab', title: string, image: nuklear.image, body: fun(ui: nuklear.ui))
---@overload fun(self: nuklear.ui, item: 'node' | 'tab', title: string, image: nuklear.image, state: 'collapsed' | 'expanded', body: fun(ui: nuklear.ui))
function ui:treeState(item, title, body) end

--#endregion
--#region ## Popups

---Start a popup with the given size and flags. Bounds can be given as either
---dynamic ratios or static pixel counts.
---
---Call `ui:popupEnd` to end the popup if it is open.
---@param layout 'dynamic' | 'static'
---@param title string
---@param x number
---@param y number
---@param width number
---@param height number
---@param ... nuklear.flags|nuklear.flags[]
---@return boolean open -- `true` if the popup is open, and `false` otherwise.
function ui:popupBegin(layout, title, x, y, width, height, ...) end

---Close the current popup.
function ui:popupClose() end

---End a popup. Be sure to call this when ending an open popup.
function ui:popupEnd() end

---Equivalent to:
---
---```lua
---if ui:popupBegin(...) then
---  body(ui)
---  ui:popupEnd()
---end
---```
---@param layout 'dynamic' | 'static'
---@param title string
---@param x number
---@param y number
---@param width number
---@param height number
---@param ... nuklear.flags|nuklear.flags[]|fun(ui: nuklear.ui) -- `body` *must* be the last argument.
function ui:popup(layout, title, x, y, width, height, ...) end

---Get the scroll position (`sx`, `sy`) of the current popup.
---@return number sx, number sy
---@nodiscard
function ui:popupGetScroll() end

---Set the scroll position (`sx`, `sy`) of the current popup.
---@param sx number
---@param sy number
function ui:popupSetScroll(sx, sy) end

--#endregion
--#region ## Context Menus

---Set up a context menu of the given size and trigger bounds. Also takes
---window flags.
---@param width number
---@param height number
---@param triggerX number
---@param triggerY number
---@param triggerWidth number
---@param triggerHeight number
---@param ... nuklear.flags|nuklear.flags[]
---@return boolean open -- `true` if the context menu is open, and `false` otherwise.
function ui:contextualBegin(width, height, triggerX, triggerY, triggerWidth, triggerHeight, ...) end

---Add an item to a context menu. Optionally specify a symbol type, image,
---and/or alignment.
---
---Call `ui:contextualEnd` at the end of an open context menu.
---@param text string
---@return boolean activated
---@overload fun(self: nuklear.ui, text: string, graphic: nuklear.symbol|nuklear.image): (activated: boolean)
---@overload fun(self: nuklear.ui, text: string, graphic: nuklear.symbol|nuklear.image, align: nuklear.alignment): (activated: boolean)
function ui:contextualItem(text) end

---Close the current context menu.
function ui:contextualClose() end

---End the current context menu. Be sure to call this at the end of an open
---context menu.
function ui:contextualEnd() end

---Equivalent to:
---
---```lua
---if ui:contextualBegin(...) then
---  body(ui)
---  ui:contextualEnd()
---end
---```
---@param width number
---@param height number
---@param triggerX number
---@param triggerY number
---@param triggerWidth number
---@param triggerHeight number
---@param ... nuklear.flags|nuklear.flags[]|fun(ui: nuklear.ui) -- `body` *must* be the last argument.
function ui:contextual(width, height, triggerX, triggerY, triggerWidth, triggerHeight, ...) end

--#endregion
--#region ## Tooltips

---Show a tooltip with the given text.
---@param text string
function ui:tooltip(text) end

---Start a tooltip with the given width.
---
---Be sure to call `ui:tooltipEnd` at the end of an open tooltip.
---@param width number
---@return boolean open -- `true` if the tooltip is open and `false` otherwise.
function ui:tooltipBegin(width) end

---End a tooltip previously started with `ui:tooltipBegin`. Call this at the
---end of every open tooltip.
function ui:tooltipEnd() end

---Equivalent to:
---
---```lua
---if ui:tooltipBegin(width) then
---  body(ui)
---  ui:tooltipEnd()
---end
---```
---@param width number
---@param body fun(ui: nuklear.ui)
function ui:tooltip(width, body) end
--#endregion
--#region ## Menus

---Start a menu bar. Menu bars stay at the top of a window even when scrolling.
---Call `ui:menubarEnd` to end one.
function ui:menubarBegin() end

---Ends a menu bar. Always call this at the end of a menu bar started with
---`ui:menubarBegin`.
function ui:menubarEnd() end

---Equivalent to:
---
---```lua
---ui:menubarBegin()
---body(ui)
---ui:menubarEnd()
---```
---@param body fun(ui: nuklear.ui)
function ui:menubar(body) end

---Start a menu of the given title and size. Optionally specify a symbol,
---image, and/or alignment.
---
---Be sure to call `ui:menuEnd` when ending open menus.
---@param title string
---@param graphic nuklear.symbol | nuklear.image
---@param width number
---@param height number
---@return boolean open -- `true` if the menu is open, and `false` otherwise.
---@overload fun(self: nuklear.ui, title: string, graphic: nuklear.symbol|nuklear.image, width: number, height: number, align: nuklear.alignment): (open: boolean)
function ui:menuBegin(title, graphic, width, height) end

---Add a menu item to the current menu. Optionally specify a symbol, image,
---and/or alignment.
---@param title string
---@return boolean activated -- `true` if the menu item is activated and `false` otherwise.
---@overload fun(self: nuklear.ui, title: string, graphic: nuklear.symbol|nuklear.image): (activated: boolean)
---@overload fun(self: nuklear.ui, title: string, graphic: nuklear.symbol|nuklear.image, align: nuklear.alignment): (activated: boolean)
function ui:menuItem(title) end

---Close the current menu.
function ui:menuClose() end

---End the current menu. Always call this at the end of any open menu.
function ui:menuEnd() end

---Equivalent to:
---
---```lua
---if ui:menuBegin(...) then
---  body(ui)
---  ui:menuEnd()
---end
---```
---@param title string
---@param graphic nuklear.symbol | nuklear.image
---@param width number
---@param height number
---@param body fun(ui: nuklear.ui)
---@overload fun(self: nuklear.ui, title: string, graphic: nuklear.symbol|nuklear.image, width: number, height: number, align: nuklear.alignment, body: fun(ui: nuklear.ui))
function ui:menu(title, graphic, width, height, body) end

--#endregion
--#region ## General

---Show a text string. Optionally specify an alignment and/or color.
---@param text string
---@overload fun(self: nuklear.ui, text: string, align: nuklear.alignment|'wrap')
---@overload fun(self: nuklear.ui, text: string, align: nuklear.alignment|'wrap', color: nuklear.color)
function ui:label(text) end

---Show an image.
---@param image nuklear.image
function ui:image(image) end

---Add a button with a title and/or a color, symbol, or image.
---@param title string
---@return boolean activated -- `true` if activated, and `false` otherwise.
---@overload fun(self: nuklear.ui, title: string, graphic: nuklear.symbol|nuklear.image): (activated: boolean)
---@overload fun(self: nuklear.ui, title: nil, color: nuklear.color): (activated: boolean)
function ui:button(title) end

---Sets whether a button is activated once per click (`'default'`) or every
---frame held down (`'repeater'`).
---@param behavior 'default' | 'repeater'
function ui:buttonSetBehavior(behavior) end

---Push button behavior.
---@param behavior 'default' | 'repeater'
function ui:buttonPushBehavior(behavior) end

---Pop button behavior.
function ui:buttonPopBehavior() end

---Add a checkbox with the given title. Either specify a boolean state
---`active`, in which case the function returns the new state, or specify a
---table with a boolean field called `value`, in which case the value is
---updated and the function returns `true` on toggled, and `false` otherwise.
---@param text string
---@param active boolean
---@return boolean active
---@overload fun(self: nuklear.ui, text: string, valueTable: { value: boolean }): (changed: boolean)
function ui:checkbox(text, active) end

---Add a radio button with the given name and/or title. The title is displayed
---to the user while the name is used to report which button is selected. By
---default, the name is the same as the title.
---
---If called with a string `selection`, the function returns the new
---`selection`, which should be the `name` of a radio button. If called with a
---table that has a string field `value`, the value gets updated and the
---function returns `true` on selection change and `false` otherwise.
---@param text string
---@param selection string
---@return string selection
---@overload fun(self: nuklear.ui, name: string, text: string, selection: string): (selection: string)
---@overload fun(self: nuklear.ui, text: string, valueTable: { value: string }): (changed: boolean)
---@overload fun(self: nuklear.ui, name: string, text: string, valueTable: { value: string }): (changed: boolean)
function ui:radio(text, selection) end

---Add a selectable item with the given text and/or image and alignment.
---
---If given a boolean `selected`, return the new state of `selected`. If given
---a table with a boolean field named `value` instead, the field gets updated and
---the function returns `true` on a change and `false` otherwise.
---@param text string
---@param selected boolean
---@return boolean selected
---@overload fun(self: nuklear.ui, text: string, image: nuklear.image, selected: boolean): (selected: boolean)
---@overload fun(self: nuklear.ui, text: string, image: nuklear.image, align: nuklear.alignment, selected: boolean): (selected: boolean)
---@overload fun(self: nuklear.ui, text: string, valueTable: { value: boolean }): (changed: boolean)
---@overload fun(self: nuklear.ui, text: string, image: nuklear.image, valueTable: { value: boolean }): (changed: boolean)
---@overload fun(self: nuklear.ui, text: string, image: nuklear.image, align: nuklear.alignment, valueTable: { value: boolean }): (changed: boolean)
function ui:selectable(text, selected) end

---Add a slider widget with the given range and step size.
---
---If given a number `current`, return the new `current` value. If given a
---table with a number field named `value` instead, the field gets updated and
---the function returns `true` on a change and `false` otherwise.
---@param min number
---@param current number
---@param max number
---@param step number
---@return number current
---@overload fun(self: nuklear.ui, min: number, valueTable: { value: number }, max: number, step: number): (changed: boolean)
function ui:slider(min, current, max, step) end

---Add a progress widget, optionally making it modifiable.
---
---If given a number `current`, return the new `current` value. If given a
---table with a number field named `value` instead, the field gets updated and
---the function returns `true` on a change and `false` otherwise.
---@param current number
---@param max number
---@return number current
---@overload fun(self: nuklear.ui, current: number, max: number, modifiable: boolean): (current: number)
---@overload fun(self: nuklear.ui, valueTable: { value: number }, max: number): (changed: boolean)
---@overload fun(self: nuklear.ui, valueTable: { value: number }, max: number, modifiable: boolean): (changed: boolean)
function ui:progress(current, max) end

---Add a color picker widget, optionally specifying format (default `'RGB'`, no
---alpha).
---
---If given a `color` string, return the new `color`. If given a table with a
---color string field named `value` instead, the field gets updated and the
---function returns `true` on change and `false` otherwise.
---@param color nuklear.color
---@return nuklear.color color
---@overload fun(self: nuklear.ui, color: nuklear.color, colorFormat: 'RGB'|'RGBA'): (color: nuklear.color)
---@overload fun(self: nuklear.ui, valueTable: { value: nuklear.color }): (changed: boolean)
---@overload fun(self: nuklear.ui, valueTable: { value: nuklear.color }, colorFormat: 'RGB'|'RGBA'): (changed: boolean)
function ui:colorPicker(color) end

---Add a property widget, which is a named number variable. Specify the range,
---step, and sensitivity.
---
---If given a number `current`, return the new `current`. If given a table with
---a number field named `value` instead, the field gets updated and the
---function returns `true` on change and `false` otherwise.
---@param name string
---@param min number
---@param current number
---@param max number
---@param step number
---@param incPerPixel number
---@return number current
---@overload fun(self: nuklear.ui, name: string, min: number, valueTable: { value: number }, max: number, step: number, incPerPixel: number): (changed: boolean)
function ui:property(name, min, current, max, step, incPerPixel) end

---Add an editable text field widget. The first argument defines the type of
---editor to use: single line 'simple' and 'field', or multi-line 'box'. The
---`valueTable` should be a table with a string field named `value`. The field
---gets updated and the function returns the edit state (one of 'commited' /
---'activated' / 'deactivated' / 'active' / 'inactive') followed by `true` if
---the text changed or `false` if the text remained the same.
---@param editorType 'simple' | 'field' | 'box'
---@param valueTable { value: string }
---@return 'commited' | 'activated' | 'deactivated' | 'active' | 'inactive' state
---@return boolean edited
function ui:edit(editorType, valueTable) end

---Manually focus the following `ui:edit` widget.
function ui:editFocus() end

---Manually unfocus the following `ui:edit` widget.
function ui:editUnfocus() end

---Add a drop-down combobox widget. `items` should be an array of strings.
---`itemHeight` defaults to the widget height, `width` defaults to widget
---width, and `height` defaults to a sensible value based on `itemHeight`.
---
---If a number `index` is specified, then the function returns the new selected
---`index`. If a table with a number field `value` is given instead, then the
---field gets updated with the currently selected index and the function
---returns `true` on change and `false` otherwise.
---@param index number
---@param items string[]
---@return number index
---@overload fun(self: nuklear.ui, index: number, items: string[], itemHeight: number): (index: number)
---@overload fun(self: nuklear.ui, index: number, items: string[], itemHeight: number, width: number): (index: number)
---@overload fun(self: nuklear.ui, index: number, items: string[], itemHeight: number, width: number, height: number): (index: number)
---@overload fun(self: nuklear.ui, valueTable: { value: number }, items: string[]): (changed: boolean)
---@overload fun(self: nuklear.ui, valueTable: { value: number }, items: string[], itemHeight: number): (changed: boolean)
---@overload fun(self: nuklear.ui, valueTable: { value: number }, items: string[], itemHeight: number, width: number): (changed: boolean)
---@overload fun(self: nuklear.ui, valueTable: { value: number }, items: string[], itemHeight: number, width: number, height: number): (changed: boolean)
function ui:combobox(index, items) end

---Start a combobox widget. This form gives complete control over the drop-down
---list (it's treated like a new window). Color/symbol/image defaults to none,
---while width and height default to sensible values based on widget bounds.
---
---Remember to call `ui:comboboxEnd` if the combobox is open.
---@param text string
---@return boolean open
---@overload fun(self: nuklear.ui, text: string, graphic: nuklear.color|nuklear.symbol|nuklear.image): (open: boolean)
---@overload fun(self: nuklear.ui, text: string, graphic: nuklear.color|nuklear.symbol|nuklear.image, width: number): (open: boolean)
---@overload fun(self: nuklear.ui, text: string, graphic: nuklear.color|nuklear.symbol|nuklear.image, width: number, height: number): (open: boolean)
function ui:comboboxBegin(text) end

---Add a combobox item, optionally specifying a symbol, image, and/or
---alignment.
---
---Return `true` if the item is activated, and `false` otherwise.
---@param text string
---@return boolean activated
---@overload fun(self: nuklear.ui, text: string, graphic: nuklear.symbol|nuklear.image)
---@overload fun(self: nuklear.ui, text: string, graphic: nuklear.symbol|nuklear.image, align: nuklear.alignment)
function ui:comboboxItem(text) end

---Close the current combobox.
function ui:comboboxClose() end

---End the current combobox. Always call this at the end of open comboboxes.
function ui:comboboxEnd() end

---Equivalent to:
---
---```lua
---if ui:comboboxBegin(...) then
---	body(ui)
---	ui:comboboxEnd()
---end
---```
---@param text string
---@param body fun(ui: nuklear.ui)
---@overload fun(self: nuklear.ui, text: string, graphic: nuklear.color|nuklear.symbol|nuklear.image, body: fun(ui: nuklear.ui))
---@overload fun(self: nuklear.ui, text: string, graphic: nuklear.color|nuklear.symbol|nuklear.image, width: number, body: fun(ui: nuklear.ui))
---@overload fun(self: nuklear.ui, text: string, graphic: nuklear.color|nuklear.symbol|nuklear.image, width: number, height: number, body: fun(ui: nuklear.ui))
function ui:combobox(text, body) end

---Return the bounds of the current widget.
---@return number x, number y, number width, number height
function ui:widgetBounds() end

---Return the position of the current widget.
---@return number x, number y
function ui:widgetPosition() end

---Return the size of the current widget.
---@return number width, number height
function ui:widgetSize() end

---Return the width of the current widget.
---@return number width
function ui:widgetWidth() end

---Return the height of the current widget.
---@return number height
function ui:widgetHeight() end

---Return `true` if the widget is hovered by the mouse, and `false` otherwise.
---@return boolean hovered
function ui:widgetIsHovered() end

---Return `true` if the given mouse button was pressed on the current widget
---and has not yet been released, and `false` otherwise. `button` is one of
---'left'/'right'/'middle' (defaults to 'left').
---@return boolean pressed
---@overload fun(self: nuklear.ui, button: 'left'|'right'|'middle'): (pressed: boolean)
function ui:widgetHasMousePressed() end

---Return `true` if the given mouse button was released on the current widget
---and has not since been pressed, and `false` otherwise. `button` is one of
---'left'/'right'/'middle' (defaults to 'left').
---@return boolean released
---@overload fun(self: nuklear.ui, button: 'left'|'right'|'middle'): (released: boolean)
function ui:widgetHasMouseReleased() end

---Return `true` if the given mouse button was pressed on the current widget
---this frame, and `false` otherwise. button is one of 'left'/'right'/'middle'
---(defaults to 'left').
---@return boolean pressed
---@overload fun(self: nuklear.ui, button: 'left'|'right'|'middle'): (pressed: boolean)
function ui:widgetIsMousePressed() end

---Return `true` if the given mouse button was released on the current widget
---this frame, and `false` otherwise. button is one of 'left'/'right'/'middle'
---(defaults to 'left').
---@return boolean released
---@overload fun(self: nuklear.ui, button: 'left'|'right'|'middle'): (released: boolean)
function ui:widgetIsMouseReleased() end

---Empty space taking up the given number of columns.
---@param cols number
function ui:spacing(cols) end

--#endregion
--#endregion

--#region # Drawing

---Draw a multi-segment line at the given screen coordinates.
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param ... number
function ui:line(x1, y1, x2, y2, ...) end

---Draw a Bézier curve with the given start, control, and end points.
---@param x1 number
---@param y1 number
---@param ctrl1x number
---@param ctrl1y number
---@param ctrl2x number
---@param ctrl2y number
---@param x2 number
---@param y2 number
function ui:curve(x1, y1, ctrl1x, ctrl1y, ctrl2x, ctrl2y, x2, y2) end

---Draw a polygon with the given draw mode and screen coordinates.
---@param mode 'fill'|'line'
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param x3 number
---@param y3 number
---@param ... number
function ui:polygon(mode, x1, y1, x2, y2, x3, y3, ...) end

---Draw a circle with the given draw mode, center screen coordinates, and
---radius.
---@param mode 'fill'|'line'
---@param x number
---@param y number
---@param r number
function ui:circle(mode, x, y, r) end

---Draw an ellipse with the given draw mode, center screen coordinates, and
---radii.
---@param mode 'fill'|'line'
---@param x number
---@param y number
---@param rx number
---@param ry number
function ui:ellipse(mode, x, y, rx, ry) end

---Draw an arc with the given draw mode, screen coordinates, radius, and
---angles.
---@param mode 'fill' | 'line'
---@param x number
---@param y number
---@param r number
---@param startAngle number
---@param endAngle number
function ui:arc(mode, x, y, r, startAngle, endAngle) end

---Draw a gradient rectangle with the given screen coordinates, size, and
---corner colors.
---@param x number
---@param y number
---@param width number
---@param height number
---@param topLeftColor nuklear.color
---@param topRightColor nuklear.color
---@param bottomLeftColor nuklear.color
---@param bottomRightColor nuklear.color
function ui:rectMultiColor(x, y, width, height, topLeftColor, topRightColor, bottomLeftColor, bottomRightColor) end

---Set the scissor area to the given screen coordinates and size.
---@param x number
---@param y number
---@param width number
---@param height number
function ui:scissor(x, y, width, height) end

---Draw the given image at the given screen bounds.
---@param img nuklear.image
---@param x number
---@param y number
---@param width number
---@param height number
function ui:image(img, x, y, width, height) end

---Draw the given string at the given screen bounds.
---@param str string
---@param x number
---@param y number
---@param width number
---@param height number
function ui:text(str, x, y, width, height) end

--#endregion

--#region # Input

---Return `true` if the given screen bounds were hovered by the mouse in the
---previous frame, and `false` otherwise.
---@param x number
---@param y number
---@param width number
---@param height number
---@return boolean hovered
function ui:inputWasHovered(x, y, width, height) end

---Return `true` if the given screen bounds are hovered by the mouse, and
---`false` otherwise.
---@param x number
---@param y number
---@param width number
---@param height number
---@return boolean hovered
function ui:inputIsHovered(x, y, width, height) end

---Return `true` if the given mouse button was pressed in the given screen
---bounds and has not yet been released, and `false` otherwise. `button` is one
---of 'left'/'right'/'middle' (defaults to 'left').
---@param button 'left'|'right'|'middle'
---@param x number
---@param y number
---@param width number
---@param height number
---@return boolean pressed
function ui:inputHasMousePressed(button, x, y, width, height) end

---Return `true` if the given mouse button was released in the given screen
---bounds and has not since been pressed, and `false` otherwise. `button` is
---one of 'left'/'right'/'middle' (defaults to 'left').
---@param button 'left'|'right'|'middle'
---@param x number
---@param y number
---@param width number
---@param height number
---@return boolean released
function ui:inputHasMouseReleased(button, x, y, width, height) end

---Return `true` if the given mouse button was pressed in the given screen
---bounds this frame, and `false` otherwise. `button` is one of
---'left'/'right'/'middle' (defaults to 'left').
---@param button 'left'|'right'|'middle'
---@param x number
---@param y number
---@param width number
---@param height number
---@return boolean pressed
function ui:inputIsMousePressed(button, x, y, width, height) end

---Return `true` if the given mouse button was released in the given screen
---bounds this frame, and `false` otherwise. `button` is one of
---'left'/'right'/'middle' (defaults to 'left').
---@param button 'left'|'right'|'middle'
---@param x number
---@param y number
---@param width number
---@param height number
---@return boolean released
function ui:inputIsMouseReleased(button, x, y, width, height) end

--#endregion

--#region # Styling
--#region ## Colors

---Construct a color string from the given components (each from 0 to 255).
---Alpha (`a`) defaults to 255.
---@param r integer
---@param g integer
---@param b integer
---@param a? integer
---@return nuklear.color color
function nuklear.colorRGBA(r, g, b, a) end

---Construct a color string from the given components (each from 0 to 255).
---Alpha (`a`) defaults to 255.
---@param h integer
---@param s integer
---@param v integer
---@param a? integer
---@return nuklear.color color
function nuklear.colorHSVA(h, s, v, a) end

---Split a color string into its number components (each from 0 to 255).
---@param color nuklear.color
---@return integer r, integer g, integer b, integer a
function nuklear.colorParseRGBA(color) end

---Split a color string into its number components (each from 0 to 255).
---@param color nuklear.color
---@return integer h, integer s, integer v, integer a
function nuklear.colorParseHSVA(color) end

---Reset color styles to their default values.
function ui:styleDefault() end

---Load a color table for quick color styling.
---
---Below is the default color table. Custom color tables must provide all of
---the same fields.
---
---```lua
---local colorTable = {
---  ['text'] = '#afafaf',
---  ['window'] = '#2d2d2d',
---  ['header'] = '#282828',
---  ['border'] = '#414141',
---  ['button'] = '#323232',
---  ['button hover'] = '#282828',
---  ['button active'] = '#232323',
---  ['toggle'] = '#646464',
---  ['toggle hover'] = '#787878',
---  ['toggle cursor'] = '#2d2d2d',
---  ['select'] = '#2d2d2d',
---  ['select active'] = '#232323',
---  ['slider'] = '#262626',
---  ['slider cursor'] = '#646464',
---  ['slider cursor hover'] = '#787878',
---  ['slider cursor active'] = '#969696',
---  ['property'] = '#262626',
---  ['edit'] = '#262626',
---  ['edit cursor'] = '#afafaf',
---  ['combo'] = '#2d2d2d',
---  ['chart'] = '#787878',
---  ['chart color'] = '#2d2d2d',
---  ['chart color highlight'] = '#ff0000',
---  ['scrollbar'] = '#282828',
---  ['scrollbar cursor'] = '#646464',
---  ['scrollbar cursor hover'] = '#787878',
---  ['scrollbar cursor active'] = '#969696',
---  ['tab header'] = '#282828'
---}
---```
function ui:styleLoadColors(colorTable) end

--#endregion
--#region ## Styles

---Set the current font.
---@param font love.Font
function ui:styleSetFont(font) end

---Push any number of style items onto the style stack.
---
---Example:
---
---```lua
---ui:stylePush {
---  ['text'] = {
---    ['color'] = '#000000'
---  },
---  ['button'] = {
---    ['normal'] = love.graphics.newImage 'skin/button.png',
---    ['hover'] = love.graphics.newImage 'skin/button_hover.png',
---    ['active'] = love.graphics.newImage 'skin/button_active.png',
---    ['text background'] = '#00000000',
---    ['text normal'] = '#000000',
---    ['text hover'] = '#000000',
---    ['text active'] = '#ffffff'
---  }
---}
---```
---@param style nuklear.style
function ui:stylePush(style) end

---Pop the most recently pushed style.
function ui:stylePop() end

---Equivalent to:
---
---```lua
---ui:stylePush(style)
---body(ui)
---ui:stylePop()
---```
---@param style nuklear.style
---@param body fun(ui: nuklear.ui)
function ui:style(style, body) end

---@class nuklear.style
---@field ['font']? love.Font
---@field ['text']? nuklear.style.text
---@field ['button']? nuklear.style.button
---@field ['contextual button']? nuklear.style.button
---@field ['menu button']? nuklear.style.button
---@field ['option']? nuklear.style.option
---@field ['checkbox']? nuklear.style.option
---@field ['selectable']? nuklear.style.selectable
---@field ['slider']? nuklear.style.slider
---@field ['progress']? nuklear.style.progress
---@field ['property']? nuklear.style.property
---@field ['edit']? nuklear.style.edit
---@field ['chart']? nuklear.style.chart
---@field ['scrollh']? nuklear.style.scrollbar
---@field ['scrollv']? nuklear.style.scrollbar
---@field ['tab']? nuklear.style.tab
---@field ['combo']? nuklear.style.combo
---@field ['window']? nuklear.style.window

---@class nuklear.style.text
---@field ['color']? nuklear.color
---@field ['padding']? { x: number, y: number }

---@class nuklear.style.button
---@field ['normal']? nuklear.color|nuklear.image
---@field ['hover']? nuklear.color|nuklear.image
---@field ['active']? nuklear.color|nuklear.image
---@field ['border color']? nuklear.color
---@field ['text background']? nuklear.color -- color
---@field ['text normal']? nuklear.color -- color
---@field ['text hover']? nuklear.color -- color
---@field ['text active']? nuklear.color -- color
---@field ['text alignment']? nuklear.alignment
---@field ['border']? number
---@field ['rounding']? number
---@field ['padding']? { x: number, y: number }
---@field ['image padding']? { x: number, y: number }
---@field ['touch padding']? { x: number, y: number }

---@class nuklear.style.option
---@field ['normal']? nuklear.color|nuklear.image
---@field ['hover']? nuklear.color|nuklear.image
---@field ['active']? nuklear.color|nuklear.image
---@field ['border color']? nuklear.color
---@field ['cursor normal']? nuklear.color|nuklear.image
---@field ['cursor hover']? nuklear.color|nuklear.image
---@field ['text normal']? nuklear.color -- color
---@field ['text hover']? nuklear.color -- color
---@field ['text active']? nuklear.color -- color
---@field ['text background']? nuklear.color -- color
---@field ['text alignment']? nuklear.alignment
---@field ['padding']? { x: number, y: number }
---@field ['touch padding']? { x: number, y: number }
---@field ['spacing']? number
---@field ['border']? number

---@class nuklear.style.selectable
---@field ['normal']? nuklear.color|nuklear.image
---@field ['hover']? nuklear.color|nuklear.image
---@field ['pressed']? nuklear.color|nuklear.image
---@field ['normal active']? nuklear.color|nuklear.image
---@field ['hover active']? nuklear.color|nuklear.image
---@field ['pressed active']? nuklear.color|nuklear.image
---@field ['text normal']? nuklear.color -- color
---@field ['text hover']? nuklear.color -- color
---@field ['text pressed']? nuklear.color -- color
---@field ['text normal active']? nuklear.color -- color
---@field ['text hover active']? nuklear.color -- color
---@field ['text pressed active']? nuklear.color -- color
---@field ['text background']? nuklear.color -- color
---@field ['text alignment']? nuklear.alignment
---@field ['rounding']? number
---@field ['padding']? { x: number, y: number }
---@field ['touch padding']? { x: number, y: number }
---@field ['image padding']? { x: number, y: number }

---@class nuklear.style.slider
---@field ['normal']? nuklear.color | nuklear.image
---@field ['hover']? nuklear.color | nuklear.image
---@field ['active']? nuklear.color | nuklear.image
---@field ['border color']? nuklear.color
---@field ['bar normal']? nuklear.color -- color
---@field ['bar active']? nuklear.color -- color
---@field ['bar filled']? nuklear.color -- color
---@field ['cursor normal']? nuklear.color | nuklear.image
---@field ['cursor hover']? nuklear.color | nuklear.image
---@field ['cursor active']? nuklear.color | nuklear.image
---@field ['border']? number
---@field ['rounding']? number
---@field ['bar height']? number
---@field ['padding']? { x: number, y: number },
---@field ['spacing']? { x: number, y: number },
---@field ['cursor size']? { x: number, y: number }

---@class nuklear.style.progress
---@field ['normal']? nuklear.color | nuklear.image
---@field ['hover']? nuklear.color | nuklear.image
---@field ['active']? nuklear.color | nuklear.image
---@field ['border color']? nuklear.color
---@field ['cursor normal']? nuklear.color | nuklear.image
---@field ['cursor hover']? nuklear.color | nuklear.image
---@field ['cursor active']? nuklear.color | nuklear.image
---@field ['cursor border color']? nuklear.color
---@field ['rounding']? number
---@field ['border']? number
---@field ['cursor border']? number
---@field ['cursor rounding']? number
---@field ['padding']? { x: number, y: number }

---@class nuklear.style.property
---@field ['normal']? nuklear.color | nuklear.image
---@field ['hover']? nuklear.color | nuklear.image
---@field ['active']? nuklear.color | nuklear.image
---@field ['border color']? nuklear.color
---@field ['label normal']? nuklear.color -- color
---@field ['label hover']? nuklear.color -- color
---@field ['label active']? nuklear.color -- color
---@field ['border']? number
---@field ['rounding']? number
---@field ['padding']? { x: number, y: number }
---@field ['edit']? nuklear.style.edit
---@field ['inc button']? nuklear.style.button
---@field ['dec button']? nuklear.style.button

---@class nuklear.style.edit
---@field ['normal']? nuklear.color | nuklear.image
---@field ['hover']? nuklear.color | nuklear.image
---@field ['active']? nuklear.color | nuklear.image
---@field ['border color']? nuklear.color
---@field ['scrollbar']? nuklear.style.scrollbar
---@field ['cursor normal']? nuklear.color -- color
---@field ['cursor hover']? nuklear.color -- color
---@field ['cursor text normal']? nuklear.color -- color
---@field ['cursor text hover']? nuklear.color -- color
---@field ['text normal']? nuklear.color -- color
---@field ['text hover']? nuklear.color -- color
---@field ['text active']? nuklear.color -- color
---@field ['selected normal']? nuklear.color -- color
---@field ['selected hover']? nuklear.color -- color
---@field ['selected text normal']? nuklear.color -- color
---@field ['selected text hover']? nuklear.color -- color
---@field ['border']? number
---@field ['rounding']? number
---@field ['cursor size']?  number
---@field ['scrollbar size']? { x: number, y: number },
---@field ['padding']? { x: number, y: number },
---@field ['row padding']? number

---@class nuklear.style.scrollbar
---@field ['normal']? nuklear.color | nuklear.image
---@field ['hover']? nuklear.color | nuklear.image
---@field ['active']? nuklear.color | nuklear.image
---@field ['border color']? nuklear.color
---@field ['cursor normal']? nuklear.color | nuklear.image
---@field ['cursor hover']? nuklear.color | nuklear.image
---@field ['cursor active']? nuklear.color | nuklear.image
---@field ['cursor border color']? nuklear.color
---@field ['border']? number
---@field ['rounding']? number
---@field ['border cursor']? number
---@field ['rounding cursor']? number
---@field ['padding']? { x: number, y: number }

---@class nuklear.style.chart
---@field ['background']? nuklear.color | nuklear.image
---@field ['border color']? nuklear.color
---@field ['selected color']? nuklear.color
---@field ['color']? nuklear.color
---@field ['border']? number
---@field ['rounding']? number
---@field ['padding']? { x: number, y: number }

---@class nuklear.style.tab
---@field ['background']? nuklear.color | nuklear.image
---@field ['border color']? nuklear.color
---@field ['text']? nuklear.color -- color
---@field ['tab maximize button']? nuklear.style.button
---@field ['tab minimize button']? nuklear.style.button
---@field ['node maximize button']? nuklear.style.button
---@field ['node minimize button']? nuklear.style.button
---@field ['border']? number
---@field ['rounding']? number
---@field ['indent']? number
---@field ['padding']? { x: number, y: number }
---@field ['spacing']? { x: number, y: number }

---@class nuklear.style.combo
---@field ['normal']? nuklear.color | nuklear.image
---@field ['hover']? nuklear.color | nuklear.image
---@field ['active']? nuklear.color | nuklear.image
---@field ['border color']? nuklear.color
---@field ['label normal']? nuklear.color -- color
---@field ['label hover']? nuklear.color -- color
---@field ['label active']? nuklear.color -- color
---@field ['symbol normal']? nuklear.color -- color
---@field ['symbol hover']? nuklear.color -- color
---@field ['symbol active']? nuklear.color -- color
---@field ['button']? nuklear.style.button
---@field ['border']? number
---@field ['rounding']? number
---@field ['content padding']? { x: number, y: number }
---@field ['button padding']? { x: number, y: number }
---@field ['spacing']? { x: number, y: number }

---@class nuklear.style.window
---@field ['header']? nuklear.style.window.header
---@field ['fixed background']? nuklear.color | nuklear.image
---@field ['background']? nuklear.color -- color
---@field ['border color']? nuklear.color
---@field ['popup border color']? nuklear.color
---@field ['combo border color']? nuklear.color
---@field ['contextual border color']? nuklear.color
---@field ['menu border color']? nuklear.color
---@field ['group border color']? nuklear.color
---@field ['tooltip border color']? nuklear.color
---@field ['scaler']? nuklear.color | nuklear.image
---@field ['border']? number
---@field ['combo border']? number
---@field ['contextual border']? number
---@field ['menu border']? number
---@field ['group border']? number
---@field ['tooltip border']? number
---@field ['popup border']? number
---@field ['rounding']? number
---@field ['spacing']? { x: number, y: number }
---@field ['scrollbar size']? { x: number, y: number }
---@field ['min size']? { x: number, y: number }
---@field ['padding']? { x: number, y: number }
---@field ['group padding']? { x: number, y: number }
---@field ['popup padding']? { x: number, y: number }
---@field ['combo padding']? { x: number, y: number }
---@field ['contextual padding']? { x: number, y: number }
---@field ['menu padding']? { x: number, y: number }
---@field ['tooltip padding']? { x: number, y: number }

---@class nuklear.style.window.header
---@field ['normal']? nuklear.color | nuklear.image
---@field ['hover']? nuklear.color | nuklear.image
---@field ['active']? nuklear.color | nuklear.image
---@field ['close button']? nuklear.style.button
---@field ['minimize button']? nuklear.style.button
---@field ['label normal']? nuklear.color | nuklear.image
---@field ['label hover']? nuklear.color | nuklear.image
---@field ['label active']? nuklear.color | nuklear.image
---@field ['padding']? { x: number, y: number }
---@field ['label padding']? { x: number, y: number }
---@field ['spacing']? { x: number, y: number }

--#endregion
--#endregion

return nuklear
