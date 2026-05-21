class AddStatusConstraintToDevlogReviews < ActiveRecord::Migration[8.1]
  def up
    # Backfill any NULL statuses to 'pending'
    DevlogReview.where(status: nil).update_all(status: "pending")

    # Add default and NOT NULL constraint
    change_column_default :devlog_reviews, :status, "pending"
    change_column_null :devlog_reviews, :status, false
  end

  def down
    change_column_null :devlog_reviews, :status, true
    change_column_default :devlog_reviews, :status, nil
  end
end
