# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Gorilla.Repo.Migrations.CreateLocks do
  use Ecto.Migration

  def change do
    create table(:locks) do
      add :token, :uuid
      add :resource, :string, unique: true
      add :owner, :string
      add :expire_at, :utc_datetime

      timestamps()
    end

    create index(:locks, [:resource])
  end
end
