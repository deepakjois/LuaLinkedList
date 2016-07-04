----------------------------------------------------------------
-- Doubly-linked List
--
-- @module LinkedList
-- @author jose@josellausas.com
-- @usage
-- dll = LinkedList:new()
-- dll:pushBack("Some data")
-- print(dll:popBack())
----------------------------------------------------------------
local class = require ('middleclass')
local Node = require('LNode')

local LinkedList = class('LinkedList')

-----------------------------------------------------
-- Removes a node from the list
--
-- @function removeNode
-- @param list **(LinkedList)** The list to remove from
-- @param node **(LNode)** The node to remove
-----------------------------------------------------
local function removeNode(list, node)
	local prevN = node.prev
	local nextN = node.next

	if(prevN ~= nil) then
		prevN.next = nextN
	else
	    -- The node was at the head
	    list.head = nextN
	end

	if(nextN ~= nil) then
		nextN.prev = prev
	else
	    -- The node was at the tail
	    list.tail = prevN
	end

	node.prev = nil
	node.next = nil
	node.data = nil

	list.count = list.count - 1
end

-----------------------------------------------------
-- Inserts a node before the reference
--
-- @function insertNodeBefore
-- @param node **(LNode)** The node to insert
-- @param referenceNode **(LNode)** The node to insert before to
-----------------------------------------------------
local function insertNodeBefore(list, node, referenceNode)
	-- Setup the node
	local before = referenceNode.prev
	if(before ~= nil) then
		before.next = node
	end
	node.prev = before
	node.next = referenceNode
	referenceNode.prev = node

	list.count = list.count + 1  
end


-----------------------------------------------------
-- Inserts a node after the reference
--
-- @function insertNodeAfter
-- @param node **(LNode)** The node to insert
-- @param referenceNode **(LNode)** The node to insert after to
-----------------------------------------------------
local function insertNodeAfter(node, referenceNode)
	local after = referenceNode.next

	if(after ~= nil) then
		after.prev = node
	end

	node.next = after
	node.prev = referenceNode

	referenceNode.next = node

end


local function insertNodeBetween(node, leftNode, rightNode)

end

----------------------------------------------------------------
-- Creates a new Doubly-linked List
----------------------------------------------------------------
function LinkedList:initialize()
	self.head  = nil
	self.tail  = nil
	self.count = 0
end

----------------------------------------------------------------
-- Returns the list's first node
--
-- @return **(LNode)** The first node or nil
----------------------------------------------------------------
function LinkedList:getHead()
	return self.head
end

----------------------------------------------------------------
-- Returns the last node
--
-- @return **(LNode)** The last node or nil
----------------------------------------------------------------
function LinkedList:getTail()
	return self.tail
end

----------------------------------------------------------------
-- Returns the number of items in the list
--
-- @return **(num)** The number of items on the list
----------------------------------------------------------------
function LinkedList:getCount()
	return self.count
end

----------------------------------------------------------------
-- Pushes the data to the back of the list inside a new Node
--
-- @param data **(any)** Any data to store in the list
----------------------------------------------------------------
function LinkedList:pushBack(data)
	local node = Node:new(data)
	if(self.head == nil) then
		self.head = node
		self.tail = node
	else
	    self.tail.next = node
	    node.prev = self.tail
	    self.tail = node
	end
	self.count = self.count + 1
end

----------------------------------------------------------------
-- Pushes the data to the front of the list inside a new node
--
-- @param data **(any)** The data to store
----------------------------------------------------------------
function LinkedList:pushFront(data)
	local node = Node:new(data)

	if(self.head == nil)then
		self.head = node
		self.tail = node
	else
		self.head.prev = node
		node.next = self.head
		self.head = node
	end

	self.count = self.count + 1
end

----------------------------------------------------------------
-- Deletas all the nodes and data references in the list
----------------------------------------------------------------
function LinkedList:deleteAll()
	if(self.head == nil) then return end

	local n = self.head
	repeat
		local nextNode = n.next
		n.data = nil
		n.next = nil
		n.prev = nil
		self.count = self.count -1
		n = nextNode
	until(n == nil)
	self.head = nil
	self.tail = nil
end

----------------------------------------------------------------
-- Pops the first element's data. Removes it from the list
--
-- @return **(data)** The first data stored in the list
----------------------------------------------------------------
function LinkedList:popFront()
	if(self.head == nil) then return nil end

	local wasHead = self.head

	if(wasHead.next ~= nil) then
		self.head = wasHead.next
		self.head.prev = nil
	end

	self.count = self.count - 1

	return wasHead.data
end

----------------------------------------------------------------
-- Removes and returns the last data in the list
--
-- @return **(data)** The last item's data
----------------------------------------------------------------
function LinkedList:popBack()
	if(self.head == nil) then return nil end

	local wasTail = self.tail

	if(wasTail.prev ~= nil) then
		self.tail = wasTail.prev
		self.tail.next = nil
	end

	self.count = self.count - 1

	return wasTail.data
end


----------------------------------------------------------------
-- Returns all the data inside the list as an array. Uses '[nil]' for nil data
--
-- return **({arr})** An array with the data.
----------------------------------------------------------------
function LinkedList:getDataArray()
	local dataArray = {}
	local node = self.head
	while node ~= nil do
		if(node.data ~= nil) then
			table.insert(dataArray, node.data)
		else
		    table.insert(dataArray, "[nil]")
		end
		node = node.next
	end
	return dataArray
end

----------------------------------------------------------------
-- Same as above but backwards ordered
--
-- @return **({arr})** An array with the data reversed.
----------------------------------------------------------------
function LinkedList:getDataArrayBackwards()
	local dataArray = {}
	local node = self.tail
	while (node ~= nil) do
		if(node.data ~= nil) then
			table.insert(dataArray, node.data)
		else
		    table.insert(dataArray, "[nil]")
		end
		node = node.prev
	end
	return dataArray
end	

----------------------------------------------------------------
-- Removes the last item on the list
----------------------------------------------------------------
function LinkedList:removeLast()
	if(self.tail == nil) then return end
	-- Remove the tail
	removeNode(self, self.tail)
end


----------------------------------------------------------------
-- Removes the first item on the list
----------------------------------------------------------------
function LinkedList:removeFirst()
	if(self.head == nil) then return end
	-- Remove the head
	removeNode(self, self.head)
end



return LinkedList