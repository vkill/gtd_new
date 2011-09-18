class AttachmentsController < ApplicationController

  inherit_resources
  respond_to :html
  actions :show
  belongs_to :software

  def download
    @attachment = resource
#    send_file @attachment.data.path, :type => @attachment.data_content_type, :disposition => 'inline'
    send_file @attachment.data.path, :type =>"application/octet-stream", :disposition => 'inline'
  end

end

