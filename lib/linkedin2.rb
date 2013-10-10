require 'forwardable'
require 'oauth2'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/time'
require 'faraday'
require 'faraday_middleware'
require 'yaml'
require 'hashie'

require 'linkedin/version'
require 'linkedin/error'
require 'linkedin/utils'
require 'linkedin/configuration'
require 'linkedin/base'
require 'linkedin/profile'
require 'linkedin/company'
require 'linkedin/industry'
require 'linkedin/faraday_middleware'
require 'linkedin/api'
require 'linkedin/client'

module LinkedIn
  def new(options={}, &block)
    Client.new options, &block
  end

  def self.method_missing(method, *args, &block)
    Client.send(method, *args, &block) if Client.respond_to?(method)
  end

  def self.r_basicprofile
    @@r_basicprofile ||= API::Permissions::R_BASICPROFILE
  end

  def self.r_emailaddress
    @@r_emailaddress ||= API::Permissions::R_EMAIL
  end

  def self.r_fullprofile
    @@r_fullprofile ||= API::Permissions::R_FULLPROFILE
  end

  def self.r_contactinfo
    @@r_contactinfo ||= API::Permissions::R_CONTACTINFO
  end

  def self.r_network
    @@r_network ||= API::Permissions::R_NETWORK
  end

  def self.rw_groups
    @@rw_groups ||= API::Permissions::RW_GROUPS
  end

  def self.rw_nus
    @@rw_nus ||= API::Permissions::RW_NUS
  end
end
