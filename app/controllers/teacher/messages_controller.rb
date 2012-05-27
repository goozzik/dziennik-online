class Teacher::MessagesController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?

  def index
    @message = current_teacher.school_class_messages.new
    @messages = current_teacher.school_class_messages
  end

  def new
    @message = current_teacher.school_class_messages.new
  end

  def edit
    @message = current_teacher.school_class_messages.find(params[:id])
  end

  def create
    @message = current_teacher.school_class_messages.build(params[:message])
    @message.save ? redirect_to(:action => "index") : render(:new)
  end

  def update
    @message = current_teacher.school_class_messages.find(params[:id])
    @message.update_attributes(params[:message]) ? redirect_to(:action => "index") : render(:edit)
  end

  def destroy
    message = current_teacher.school_class_messages.find(params[:id])
    redirect_to(:action => "index") if message.destroy
  end

end
