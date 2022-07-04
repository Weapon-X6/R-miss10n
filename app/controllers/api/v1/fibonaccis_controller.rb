class Api::V1::FibonaccisController < ApplicationController

    # GET /fibonacci
    def index
        @fibos = Fibonacci.all
        render json: @fibos, except: [:id]
    end

    # POST /fibonacci
    def create
        #puts ">> #{params}"
        if params[:n].present?       
            @fibo = Fibonacci.new() 
            value = params[:n].to_i 
            @fibo.value = value
            @fibo.result = fibonacci(value) 
            #@fibo.runtime = _PEND
    
            render json: @fibo
        else
            render json: {error: 'Required parameter \'n\' is missing'}, status: :bad_request
        end        
    end

    private

    def fibonacci(n)
        f = n < 2 ? n : fibonacci(n-1) + fibonacci(n-2)
    end

end
