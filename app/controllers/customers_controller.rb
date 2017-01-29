class CustomersController < ApplicationController
 
 before_action :authenticate_user!, only: [:new,:create,:edit,:update,:destroy,:index,:show]

 before_action :find_params,only:[:show,:edit,:destroy,:update]  
#基本課題01

  def index
    # @customers = Customer.all
    # @customers= Customer.page(params[:page])
    
    @q = Customer.search(params[:q])
    @customers = @q.result(distinct: true).page(params[:page])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
      if @customer.save
        redirect_to @customer
      else
        render :new
      end
  end

  def edit
    #@customer= Customer.find(params[:id])
  end

  def update
    
    #@customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        redirect_to @customer
      else
        render :edit
      end
    
  end

  def show
    #@customer = Customer.find(params[:id]) 
    @comment = Comment.new #これをform_forで使用。
    #@comments = Commnet.where(customer_id: params[:id].to_i)
    @comments = @customer.comments
  end

  def destroy
   #@customer = Customer.find(params[:id])
   @customer.destroy
   redirect_to root_path
  end
  
  private
  
  def customer_params
   params.require(:customer).permit(
     :family_name,
     :given_name,
     :email,
     :company_id,
     :post_id
     )
  end
  
  def find_params
    @customer = Customer.find(params[:id])
  end
 #基本課題01
  
end
