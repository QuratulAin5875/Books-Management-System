class FixAuthorEmailsBeforeDevise < ActiveRecord::Migration[7.1]
  def up
    # Fix NULL or empty emails first
    execute <<-SQL
      UPDATE authors
      SET email = CONCAT('temp_email_', id, '@example.com')
      WHERE email IS NULL OR email = '';
    SQL

    # Fix duplicate emails by appending id
    execute <<-SQL
      WITH duplicates AS (
        SELECT id, email,
          ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn
        FROM authors
        WHERE email IS NOT NULL AND email <> ''
      )
      UPDATE authors
      SET email = authors.email || '_dup_' || duplicates.rn
      FROM duplicates
      WHERE authors.id = duplicates.id AND duplicates.rn > 1;
    SQL
  end

  def down
    # no rollback needed
  end
end
