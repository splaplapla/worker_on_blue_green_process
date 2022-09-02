# frozen_string_literal: true

require "English"
require_relative "blue_green_process/version"
require_relative  "blue_green_process/master_process"
require_relative  "blue_green_process/worker_process"
require_relative  "blue_green_process/base_worker"
require_relative  "blue_green_process/config"
require_relative  "blue_green_process/performance"
require_relative  "blue_green_process/shared_variable"
require "benchmark"
require "json"
require "singleton"

module BlueGreenProcess
  PROCESS_STATUS_ACTIVE = :active
  PROCESS_STATUS_INACTIVE = :inactive

  PROCESS_COMMAND_DIE = "die"
  PROCESS_COMMAND_BE_ACTIVE = "be_active"
  PROCESS_COMMAND_BE_INACTIVE = "work"
  PROCESS_COMMAND_WORK = "be_inactive"

  RESPONSE_OK = "OK"
  RESPONSE_ERROR = "ERR"

  def self.new(worker_instance:, max_work:)
    BlueGreenProcess::MasterProcess.new(worker_instance: worker_instance, max_work: max_work)
  end

  def self.configure
    @config = Config.new
    yield(@config)
    true
  end

  def self.config
    @config ||= Config.new
  end

  def self.logger
    config.logger
  end

  def self.performance
    @performance ||= Performance.new
  end

  def self.reset
    @config = Config.new
    @performance = Performance.new
  end
end
