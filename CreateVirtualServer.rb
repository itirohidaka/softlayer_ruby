#!/usr/bin/env ruby
#=======================================================================
# File: puppetagent_v1.sh
# Title: Puppet Agent Installation Script for Ubuntu Server 14.04
# Author: Gerson Itiro Hidaka
# Date: 01/06/2015
#=======================================================================
# References
# http://sldn.softlayer.com/reference/services/SoftLayer_Virtual_Guest/createObject
#=======================================================================

require 'rubygems'
require 'softlayer_api'
require 'json'

$SL_API_USERNAME = "<username>"         # enter your username here
$SL_API_KEY = "<apikey>"
virtual_guest_service = SoftLayer::Service.new("SoftLayer_Virtual_Guest")

begin
  templateObject = {
    'complexType' => "SoftLayer_Virtual_Guest",
    'hostname' => '<hostname>',
    'domain' => '<domain>',
    'startCpus' => 1,
    'maxMemory' => 1024,
    'hourlyBillingFlag' => true,
    'operatingSystemReferenceCode' => 'UBUNTU_LATEST',
    'localDiskFlag' => true,
    'postInstallScriptUri' => 'https://raw.githubusercontent.com/itirohidaka/softlayer/master/puppetagent_v2.sh',
    'datacenter' => {
        'name' => 'mon01' },
    'networkComponents' => [
        {
            'maxSpeed' => 100
        }
    ],
    'primaryNetworkComponent' => {
        'networkVlan' => {
            'id' => <vlanid>
        }
    },
    'primaryBackendNetworkComponent' => {
        'networkVlan' => {
            'id' => <vlanid>
        }
    },
  }

  # Create new virtual server
  result = virtual_guest_service.createObject(templateObject);
  # Shows the result.
  puts "****************************************"
  puts JSON.pretty_generate(result)
  puts "****************************************"
  # Add a tag to Virtual Server
  guest_id = result['id']
  result = virtual_guest_service.object_with_id(guest_id).setTags("itiro")
rescue => e
  $stdout.print(e.inspect)
end
