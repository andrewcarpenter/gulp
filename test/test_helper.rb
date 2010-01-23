require 'rubygems'
require 'test/unit'
require 'shoulda'

# TODO: remove this
I_KNOW_I_AM_USING_AN_OLD_AND_BUGGY_VERSION_OF_LIBXML2 = 1

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'gulp'

class Test::Unit::TestCase
end
