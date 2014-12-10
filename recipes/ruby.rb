apt_repository 'brightbox-ruby' do
  uri          'ppa:brightbox/ruby-ng'
  distribution node['lsb']['codename']
end

package "ruby2.1"
package "ruby2.1-dev"