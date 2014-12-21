class ADB
  @devices
  @device

  def initialize
    @devices = []
    @device = ""
  end

  def deviceCount
      return @devices.length
  end

  def getDevices
    cmd = eval("`adb devices | sed '/List.*/d' | grep -Po "^[a-zA-Z0-9]+"`")

    cmd.split(/\n/).each do |line|
      @devices.push(line)
    end
  end

  def setDevice(devicename)
    @device = devicename
  end

  def listPackages
    return eval("`adb shell 'pm list packages -f' | sed 's/package://' | sed 's/=.*//' | sort`")
  end

  def install(path)
    return eval("`adb install -r #{path}`")
  end

  def pull(path)
    return eval("`adb pull #{path}`")
  end
end
