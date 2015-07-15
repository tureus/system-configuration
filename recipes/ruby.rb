apt_repository 'brightbox-ruby' do
  uri          'ppa:brightbox/ruby-ng'
  distribution node['lsb']['codename']
end

package "ruby2.2"
package "ruby2.2-dev"