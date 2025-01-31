# Cookbook Name:: dovecot
# Recipe:: from_package
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2013-2014 Onddo Labs, SL.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node['dovecot']['packages'].each do |type, pkgs|
  if pkgs.is_a?(String)
    pkgs = [pkgs]
  elsif !pkgs.is_a?(Array)
    raise "`node['dovecot']['packages']['#{type}']` should contain an array "\
          "of packages. You passed: #{pkgs.inspect}"
  end

  pkgs.each do |pkg|
    package "(#{type}) #{pkg}" do
      package_name pkg
      only_if { DovecotCookbook::Conf.require?(type, node['dovecot']) }
    end # package
  end # pkg.each
end # node['dovecot']['packages'].each
