class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  # add routes
  get '/bakeries' do
    bakeries = Bakery.all.order(:title)
    bakeries.to_json
  end

  get '/bakeries/:id' do

    bakery = Bakery.find(params[:id])
    bakery.to_json(only: [ :name], include: {
      baked_goods: { only: [:name, :price, :bakery_id]
      }}
    )
  end

  get '/baked_goods/by_price' do
    baked_goods = BakedGood.all.order("price DESC")
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    baked_goods = BakedGood.all.find_by("price = 5")
    baked_goods.to_json
  end

end
