%(
  packer
  terminator
  vagrant
  vim
).each do |rcp|
  include_recipe rcp
end
