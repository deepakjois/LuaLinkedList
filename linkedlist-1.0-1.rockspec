package = "LinkedList"
version = "1.0-1"
source = {
	url = "" -- TODO: Put url here
}
description = {
	summary = "A Doubly-Linked List implementation",
	detailed = [[
		TODO
	]],
	homepage = "http://josellausas.com",
	license = "Apache 2.0"
}
dependencies = {
	"lua",
	"middleclass",
}
build = {
	type = "builtin",
	modules = {
		LinkedList = "LinkedList.lua",
	}
	-- copy_directories = {"Docs"},
}

