#
# Cookbook Name:: mahout
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
install_version = "0.9"
download_filepath="/tmp/mahout.tar.gz"
install_path = "/usr/local"
install_sym_path = "/usr/local/bin/mahout"
bin_path = "#{install_path}/mahout-distribution-#{install_version}/bin/mahout"

%w{java-1.6.0-openjdk java-1.6.0-openjdk-src java-1.6.0-openjdk-devel}.each do |pkg|
  package pkg do
    action :install 
  end
end

bash "install_mahout" do
  code <<-EOL
    wget ftp://ftp.riken.jp/net/apache/mahout/#{install_version}/mahout-distribution-#{install_version}.tar.gz -O #{download_filepath}
    tar xvzf #{download_filepath} -C #{install_path}
    rm -f #{install_sym_path}
    ln -s #{bin_path} #{install_sym_path}
    rm #{download_filepath}
  EOL
end

template "/home/vagrant/.bashrc" do
  source "dot.bashrc.erb"
  variables :partials => {
    "mahout.bashrc.erb" => "hack the planet",
  },
  :top_level => "I'm a variable from the template resource"
end
