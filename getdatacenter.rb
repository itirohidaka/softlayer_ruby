#!/usr/bin/env ruby
#==============================================================================
# File: getDatacenter.rb
# Title: List the available SoftLayer's Datacenters
# Description: Ruby Script to list the current available SoftLayer's Datacenters
# Author: Gerson Itiro Hidaka
# Date: 07/06/2015 (dd/mm/yyy)
#==============================================================================
# Disclaimer
# Be aware that all scripts are run at your own risk and while every script has
# been written with the intention of minimising the potential for unintended
# consequences, the owners, hosting providers and contributers cannot be held
# responsible for any misuse or script problems.
#==============================================================================

require 'rubygems'
require 'softlayer_api'

$SL_API_USERNAME = "<username>"         # enter your username here
$SL_API_KEY = "<apikey>"
virtual_guest_service = SoftLayer::Service.new("SoftLayer_Virtual_Guest")
guest_id = <vsid> #Virtual Server ID

begin
  result = virtual_guest_service.object_with_id(guest_id).getDatacenter
	puts result
rescue Exception => exception
    puts "Unable to retrieve account information: #{exception}"
end
