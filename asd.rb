require './adb'
require './tools'

class ASD
	@menu_tree
	@menu_path

	@apk_path

	@tools
	@adb

	def initialize
		# if you have chosen 1. option, then 3. option and then 4. option, path would be: [1,3,4]
		@menu_path = []


		@tools = Tools.new
		@adb = ADB.new


		#	Menu format:
		#	[
		#		[ <MENU INFO> , <EXAMPLE> ],
		#		{
		#			[ <SELECTION NUMBER> , <HAS SUBMENU?> , <SELECTION TITLE> ],
		#			{
		#				And again; [ <MENU INFO> , <EXAMPLE> ...............
		#			}
		#		}
		#	]



		@menu_tree = [
			["Explore menu with number keys and confirm selection with enter", "Example: 1[Enter]"],
			{
				[1, true, "Setting up"] => [
					["Set up apk location and folder structure to make things cleaner",""],
					{
						[1, false, "Path to apk"] => Proc.new do
							print "Give .apk path\n> "
							@apk_path = gets.chomp
							if not File.exist?(@apk_path)
								puts "No .apk at such location. Try again!"
							end
						end,

						[2, false, "Project name"] => Proc.new do
							print "Give project name\n> "
							@tools.setProjectName(gets.chomp)
						end,

						[3, false, "Create folder tree"] => Proc.new do
							@tools.createFolders
							@tools.cloneApk(@apk_path)
						end,

						[4, false, "Open old project"] => Proc.new do
							@tools.getProjectNames.each do |name|
								puts "\t#{name}"
							end

							puts

							print "Give project name\n> "
							@tools.setProjectName(gets.chomp)
						end,

						[0, false, "Menu"] => Proc.new do
							@menu_path = []
						end
					}
				],
				[2, true, "Reverse-engineer"] => [
					["Here you can do tricks with the apk", ""],
					{
						[1, false, "Detonate"] => Proc.new do
							print "Apktool decompiling... "
							@tools.apktool_decompile(true)
							puts "Done!"
							print "Unzipping... "
							@tools.unzip(true)
							puts "Done!"
							print ".dex to .jar... "
							@tools.dex2jar(true)
							puts "Done!"
							print ".dex to java sources... "
							@tools.jd_core_java(true)
							puts "Done!"
						end,

						[2, false, "Build cracked"] => Proc.new do
							print "Unzipping... "
							@tools.unzip(false)
							puts "Done!"
							print ".dex to .jar... "
							@tools.dex2jar(false)
							puts "Done!"
							print ".dex to java sources... "
							@tools.jd_core_java(false)
							puts "Done!"
						end,

						[3, false, "Build and sign"] => Proc.new do
							print "Building apk... "
							@tools.apktool_build
							puts "Done!"
							print "Signing... "
							@tools.apk_sign
							puts "Done!"
						end,

						[0, false, "Menu"] => Proc.new do
							@menu_path = []
						end
					}
				],
				[3, true, "ADB Tool"] => [
					["Here you can download, upload or install APK from your Android device", "Example: com.example.game-1.apk[Enter]"],
					{
						[1, false, "List APKs"] => Proc.new do
							print "Asking for installed apps... "
							puts "Done!"
							puts @adb.listPackages
						end,

						[2, false, "Pull APK"] => Proc.new do
							print "Give APK path\n> "
							@adb.pull(gets.chomp)
							print "Pulling APK..."
							puts "Done!"
						end,

						[3, false, "Install APK"] => Proc.new do
							@adb.install(@tools.getPath+"/apk/signed.apk")
						end,

						[0, false, "Menu"] => Proc.new do
							@menu_path = []
						end
					}
				],
				# Temporarily false, because there is no preferences yet
				[9, false, "Preferences"] => Proc.new do
					puts "Under construction"
				end,

				[0, false, "Exit"] => Proc.new do
					exit
				end
			}
		]
	end



	def printBanner
		puts "________________________________________________\n\n"
		puts "  _____          _____           ____           "
		puts " |  _  |        |   __|         |    \\          "
		puts " |     |        |__   |         |  |  |         "
		puts " |__|__|ndroid  |_____|oftware  |____/ etonator "
		puts "\n                   By b10011                    \n"
		puts "________________________________________________\n\n"
	end



	def printMenu
		menu = getMenu
		if menu == "Function"
			puts "ERROR! @menu_path refers to Proc instead of menu!"
			return
		end
		menu.each do |h|
			next if h.class != Hash
			h.keys.each do |k|
				puts "#{k[0]}. #{k[2]}"
			end
		end
	end



	def _getSubmenu(menu, submenu)
		# menu == Menu in format of @menu_tree
		# submenu = Number, which submenu to select. Number can be found in menu as key[0] of the hash.
		menu.each do |h|
			next if h.class != Hash
			h.keys.each do |k|
				if k[0] == submenu
					if k[1] == true
						return h[k]
					end
					if k[1] == false
						h[k].call
						return "Function"
					end
				end
			end
		end
		return nil
	end



	def _getSubmenuInfo(menu, submenu, last)
		menu.each do |h|
			next if h.class != Hash
			h.keys.each do |k|
				if k[0] == submenu
					return k[1] if last

					if k[1] == true
						return h[k]
					end
				end
			end
		end
		return nil
	end



	def getMenu(path = @menu_path)
		return @menu_tree if path.length == 0  #Maybe not necessary....

		tmp = @menu_tree
		path.each do |p|
			tmp = _getSubmenu(tmp, p)
		end
		return tmp
	end



	def _hasSubmenu?
		tmp = @menu_tree
		@menu_path.each_with_index do |p,i|
			tmp = _getSubmenuInfo(tmp, p, (i == @menu_path.length-1))
		end
		return tmp
	end

	def setPath(path)
		@menu_path = path
	end

	def getPath
		return @menu_path
	end



	def parseCommand(command)
		command.chomp!
		errors = false

		command.each_char do |c|
			if ((not (48..57) === c.ord) and c.ord != 32)
				errors = true
			end
		end

		@menu_path.push(command.to_i)

		getMenu

		@menu_path.pop if not _hasSubmenu?

		return nil if errors
	end
end
