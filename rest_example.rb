require 'sinatra'
require 'JSON'
require './sale_item'

# test sinatra for now, rails later

saleItemDao = SaleItemDao.new

get '/items' do
  puts saleItemDao.get_all.to_json
end

get '/items/:id' do
  item = saleItemDao.get(params[:id])
  return status 404 if item.nil?
  item.to_json
end

post '/items' do
  request.body.rewind
  new_item = JSON.parse request.body.read
  sale_item = SaleItem.new(new_item['item_number'], new_item['item_description'], new_item['number_in_stock'])

  saleItemDao.add(sale_item)
end

# TODO: add in sales metrics