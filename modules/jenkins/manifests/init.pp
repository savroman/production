# jenkins
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include jenkins
class jenkins (
  $plugins  = ['sonar', 'maven-plugin', 'jquery']
  ){
  include jenkins::install
}
