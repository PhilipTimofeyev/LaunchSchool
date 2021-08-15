class SecretFile
  def initialize(secret_data, logger)
    @data = secret_data
    @log = logger
  end

  def data
    @log.create_log_entry
    @data
  end

end

class SecurityLogger
  def create_log_entry
    "Data accessed at #{Time.now}"
  end
end

x = SecretFile.new("Hmm", SecurityLogger.new)
p x.data


