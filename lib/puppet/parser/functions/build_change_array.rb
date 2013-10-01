# Function: build_change_array
#
#   Construct an array from the $porperties hash and add the set keyword
module Puppet::Parser::Functions
  newfunction(:build_change_array, :type => :rvalue) do |args|

    array = Array.new
    args[0].each do |key, value|
      array << "set #{key} #{value}"
    end
    array

  end
end
