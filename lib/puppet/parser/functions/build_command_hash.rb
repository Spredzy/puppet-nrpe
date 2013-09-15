# Function: build_command_hash
#
#   Construct the apprioriate hast for use in create_resources
#   from the hash passed from checks
#
module Puppet::Parser::Functions
  newfunction(:build_command_hash, :type => :rvalue) do |args|

    h = Hash.new
    args[0].each do |key, value|
      h[key] = { 'command' => value }
    end
    h

  end
end
