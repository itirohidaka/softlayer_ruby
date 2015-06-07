#!/usr/bin/env ruby
#==============================================================================
# File: CreateVirtualServer.rb
# Title: Create a Virtual Server on IBM Cloud (SoftLayer)
# Description: Ruby Script to create a Virtual Server using a template object
#              postInstallScript, using a specific private and public vlan,
#              and inserting a tag.
# Author: Gerson Itiro Hidaka
# Date: 07/06/2015 (dd/mm/yyy)
#==============================================================================
# References
# http://sldn.softlayer.com/reference/services/SoftLayer_Virtual_Guest/createObject
#==============================================================================
# Disclaimer
# Be aware that all scripts are run at your own risk and while every script has
# been written with the intention of minimising the potential for unintended
# consequences, the owners, hosting providers and contributers cannot be held
# responsible for any misuse or script problems.
#==============================================================================

require 'rubygems'
require 'softlayer_api'
require 'json'

#Substitute <username> with you SoftLayer's username
$SL_API_USERNAME = "<username>"         # enter your username here
#Substitute <apikey> with you SoftLayer's API Key string
$SL_API_KEY = "<apikey>"
virtual_guest_service = SoftLayer::Service.new("SoftLayer_Virtual_Guest")

#Substitute <hostname> with the virtual server desired hostname
#Substitute <domain> with virtual server domain
#Substitute <vlanid1> with Public Vlan ID
#Substitute <vlanid2> with Private Vlan ID
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
            'id' => <vlanid1>
        }
    },
    'primaryBackendNetworkComponent' => {
        'networkVlan' => {
            'id' => <vlanid2>
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
