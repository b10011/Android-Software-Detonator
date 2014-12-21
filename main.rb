require './asd'

asd = ASD.new
asd.printBanner

asd.printMenu

while true
	print "\n> "
	asd.parseCommand(gets)
	puts
	asd.printMenu
end
