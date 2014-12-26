require 'Logger'

module Api
  module V1
    class ItemsController < ApplicationController
      respond_to :json

      def index
        if params[:item_id].present?
          ids = params[:item_id]
          ids = ids.split(',').map &:to_i
          render json: InvType.where(type_id: ids)
        elsif params[:item_name].present?
          names = params[:item_name]
          names = names.split(',').map &:to_s
          render json: InvType.where(type_name: names).select('inv_type.type_id', 'inv_type.type_name')
        end
      end

      def create
        l = Logger.new('log/test2.log')
        if params[:ore_name].present? and params[:batch_size].present? and params[:tritanium].present? and params[:pyerite].present? and params[:mexallon].present? and params[:isogen].present? and params[:nocxium].present? and params[:megacyte].present? and params[:zydrine].present? and params[:morphite].present?
          ore_names = params[:ore_name].split(',').map &:to_s
          batch_sizes = params[:batch_size].split(',').map &:to_i
          tri = params[:tritanium].split(',').map &:to_i
          pye = params[:pyerite].split(',').map &:to_i
          mex = params[:mexallon].split(',').map &:to_i
          iso = params[:isogen].split(',').map &:to_i
          noc = params[:nocxium].split(',').map &:to_i
          zyd = params[:zydrine].split(',').map &:to_i
          meg = params[:megacyte].split(',').map &:to_i
          mor = params[:morphite].split(',').map &:to_i

          ores = {}

          ore_names.each_with_index do |ore, idx|
            minerals = {}
            minerals['Tritanium'] = tri[idx]
            minerals['Pyerite'] = pye[idx]
            minerals['Mexallon'] = mex[idx]
            minerals['Isogen'] = iso[idx]
            minerals['Nocxium'] = noc[idx]
            minerals['Megacyte'] = meg[idx]
            minerals['Zydrine'] = zyd[idx]
            minerals['Morphite'] = mor[idx]
            ores[ore] = minerals
          end

          l.error(ores.to_json)

          ore_ids = InvType.where(type_name: ore_names).select('inv_type.type_id', 'inv_type.type_name')
          mineral_names = ['Tritanium','Pyerite','Mexallon','Isogen','Nocxium','Megacyte','Zydrine','Morphite']
          mineral_ids = InvType.where(type_name: mineral_names).select('inv_type.type_id', 'inv_type.type_name')

          l.error(mineral_ids)

          b, b_size = [], 500

          ore_ids.each do |ore|
            ore_name = ore['type_name']
            mineral_ids.each do |mineral|
              mineral_name = mineral['type_name']
              if ores[ore_name][mineral_name] > 0
                l.error(ore_name)
                l.error(mineral_name.to_s + ' ' + ores[ore_name][mineral_name].to_s)
                b << OreRefining.new(:type_id => ore['type_id'], :type_name => ore_name, :material_type_id => mineral['type_id'], :material_type_name => mineral_name, :input => 100, :output => ores[ore_name][mineral_name])
              end
            end
          end
          OreRefining.import(b)
          render status: :created
        else
          render nothing: true
        end
      end

      def show

        if params[:id].present?
          ores = InvType.joins(:inv_type_materials).where(type_id: params[:id]).select('inv_type_material.type_id', 'inv_type_material.material_type_id', 'inv_type_material.quantity')
          #ores = InvType.inv_type_materials.select('inv_type.type_name','inv_type_material.material_type_id','inv_type_material.quantity').find(params[:id])
          render json: ores
        else
          render nothing: true
        end
      end

    end
  end
end