class UserWordController < ApplicationController
    before_action :authenticate_user!, only: [:getAWord, :getADefinition, :getSynonym, :getAntonym, :geAtExample]
    before_action :get_current_user, only: [:getAWord, :getADefinition, :getSynonym, :getAWord, :getAExample, :getAntonym]
    before_action :get_params, only: [:getSynonym, :getAWord, :getADefinition, :getSynonym, :getAExample, :getAntonym]
    before_action :is_valid_api_key?, only: [:getAWord, :getADefinition, :getSynonym,:getAntonym,:getAExample]
    before_action :is_valid_word?, only: [:getADefinition, :getSynonym, :getAExample, :getAntonym]
    


    def getAWord
        all_ids=AllWord.ids.shuffle!.first
        @word=AllWord.find_by(id: all_ids).word_name
        render json: @word
    end

    def getError
        not_found
    end
    
    def getADefinition
        current_word=@user_params[:word]
        word_id=AllWord.find_by(word_name: current_word).id
        @definition=Definition.where(all_word_id: word_id)
        definition_arr=[]
        @definition.each do |definition|
            definition_arr.push(definition["text"])
        end
        render json: {"word": current_word, "definitions": definition_arr}
    end

    def getAExample
        current_word=@user_params[:word]
        word_id=AllWord.find_by(word_name: current_word).id
        @example=Example.where(all_word_id: word_id)
        example_arr=[]
        @example.each do |example|
            example_arr.push(example["text"])
        end
        render json: {"word": current_word, "examples": example_arr}
    end

    def getSynonym
        current_word=@user_params[:word]
        word_id=AllWord.find_by(word_name: current_word).id
        @synonym=Synonym.where(all_word_id: word_id)
        synonym_arr=[]
        @synonym.each do |synonym|
            synonym_arr.push(synonym["text"])
        end
        render json: {"word": current_word, "synonyms": synonym_arr}
    end

    def getAntonym
        current_word=@user_params[:word]
        word_id=AllWord.find_by(word_name: current_word).id
        @antonym=Antonym.where(all_word_id: word_id)
        antonym_arr=[]
        @antonym.each do |antonym|
            antonym_arr.push(antonym["text"])
        end
        render json: {"word": current_word, "antonyms": antonym_arr}
    end

    private
    def get_params
        @user_params=params
        return @user_params
    end

    def get_current_user
        @current_user = current_user
        return @current_user
    end

    def is_valid_word?
        current_word=@user_params[:word]
        if AllWord.find_by(word_name: current_word)==nil
            render json: {error: 'Invalid word'}, status: 401
        end
    end

    def is_valid_api_key?
        api_key=@user_params[:api_key]
        if AllKey.find_by(api_key: api_key)==nil
            render json: {error: 'Invalid API key'}, status: 401
        else
            if @current_user.subscription_type==1
                curr_obj=AllKey.find_by(api_key: api_key)
                if curr_obj.frequency+1>500
                    flash[:notice]="You have exhausted the daily limit of 500 API calls"
                    ApiKey.find_by(api_key: api_key).destroy
                    AllKey.find_by(api_key: api_key).destroy
                    redirect_to root_path
                else
                    curr_obj.frequency+=1
                    curr_obj.save
                end
            elsif @current_user.subscription_type==2
                curr_obj=AllKey.find_by(api_key: api_key)
                if curr_obj.frequency+1>2000
                    flash[:notice]="You have exhausted the monthly limit of 2000 API calls"
                    ApiKey.find_by(api_key: api_key).destroy
                    AllKey.find_by(api_key: api_key).destroy
                    redirect_to root_path
                else
                    curr_obj.frequency+=1
                    curr_obj.save
                end
            else
                curr_obj=AllKey.find_by(api_key: api_key)
                if curr_obj.frequency+1>10000
                    flash[:notice]="You have exhausted the yearly limit of 10000 API calls"
                    ApiKey.find_by(api_key: api_key).destroy
                    AllKey.find_by(api_key: api_key).destroy
                    redirect_to root_path
                else
                    curr_obj.frequency+=1
                    curr_obj.save
                end
            end
    end
end
end



