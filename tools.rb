require 'fileutils'

class Tools
	@projects
	@project
	@apk_path

	def initialize
		@projects = "projects/"
		@project = nil

	end

	def validOptions
		invalids = 0

		invalids += 1 if @project == nil

		return true if invalids == 0
		return false
	end

	def setProjectName(name)
		@project = name
	end

	def createFolders
		return if not validOptions
		[
			"/apk",
			"/java",
			"/jar",
			"/reversed",
			"/unzip",
			"/java/original",
			"/java/cracked",
			"/reversed/original",
			"/reversed/cracked",
			"/unzip/original",
			"/unzip/cracked"
		].each do |subfolder|
			FileUtils::mkdir_p(@projects+@project+subfolder)
		end
	end

	def unzip(original)
		return if not validOptions

		version = "cracked"
		version = "original" if original

		cmd = eval("`unzip #{@projects+@project+"/apk/#{version}.apk"} -d #{@projects+@project+"/unzip/#{version}"}`")

	end

	def dex2jar(original)
		return if not validOptions

		version = "cracked"
		version = "original" if original
		cmd = eval("`dex2jar/d2j-dex2jar.sh -ts #{@projects+@project+"/unzip/#{version}/classes.dex -o #{@projects+@project+"/jar/#{version}.jar"}"}`")

	end

	def jd-core-java(original)



	end

	def apktool_build(original)



	end

	def apktool_decompile(original)



	end

	def apk-sign(original)



	end
end
