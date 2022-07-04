class Api::V1::FibonaccisController < ApplicationController

    require 'benchmark'

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
            time_s = Benchmark.measure {
                @fibo.result = fibonacci(value) 
            }
            time_ms = time_s.real*1000
            @fibo.runtime = time_ms.to_s
    
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