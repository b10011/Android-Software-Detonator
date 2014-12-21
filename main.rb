require './asd'

asd = ASD.new
asd.printBanner
#asd.setPath([1,1,123])

asd.printMenu

while true
	print "\n> "
	asd.parseCommand(gets)
	puts
	asd.printMenu
end
