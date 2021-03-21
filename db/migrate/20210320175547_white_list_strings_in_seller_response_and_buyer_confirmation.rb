class WhiteListStringsInSellerResponseAndBuyerConfirmation < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      ALTER TABLE trades
        ADD CONSTRAINT seller_response_check
        CHECK (seller_response ~* '(accept|decline|unactioned)');
    SQL
    execute <<-SQL
      ALTER TABLE trades
        ADD CONSTRAINT buyer_response_check
        CHECK (buyer_response ~* '(confirm|decline|unactioned)');
    SQL
  end

  def down
   execute <<-SQL
      ALTER TABLE trades
        DROP CONSTRAINT seller_response_check
    SQL
    execute <<-SQL
      ALTER TABLE trades
        DROP CONSTRAINT buyer_response_check
    SQL
  end
end
