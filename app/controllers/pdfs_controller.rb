class PdfsController < ApplicationController
  
  def metadata
    render json: {
      test: 'some stuff'
    }
  end
end
