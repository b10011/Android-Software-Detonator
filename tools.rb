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

		cmd = eval("`unzip #{@projects+@project}/apk/#{version}.apk"} -d #{@projects+@project}/unzip/#{version}"}`")

	end

	def dex2jar(original)
		return if not validOptions

		version = "cracked"
		version = "original" if original
		cmd = eval("`tools/dex2jar/d2j-dex2jar.sh -ts #{@projects+@project}/unzip/#{version}/classes.dex -o #{@projects+@project}/jar/#{version}.jar`")

	end

	def jd-core-java(original)
		return if not validOptions

		version = "cracked"
		version = "original" if original

		cmd = eval("`java -jar tools/jd-core-java.jar #{@projects+@project}/jar/#{version}.jar #{@projects+@project}/java/#{version}`")

	end

	def apktool_build

		cmd = eval("`java -jar tools/apktool.jar b -f #{@projects+@project}/reversed/cracked/ -o #{@projects+@project}/apk/cracked.apk`")

	end

	def apktool_decompile(original)

		cmd = eval("`java -jar tools/apktool.jar d -f #{@projects+@project}/apk/original.apk -o #{@projects+@project}/reversed/original`")
		FileUtils::cp_r("#{@projects+@project}/reversed/original", "#{@projects+@project}/reversed/cracked")

	end

	def apk-sign
		return if not validOptions

		cmd = eval("`tools/dex2jar/d2j-apk-sign.sh -f #{@projects+@project}/cracked.apk -o #{@projects+@project}/signed.apk`")

	end
end
