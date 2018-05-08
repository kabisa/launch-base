class KabisiansController < ApplicationController
  def show
    @kabisian = Kabisian.first
  end
end
