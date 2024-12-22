CREATE TABLE "users"(
    "id" SERIAL NOT NULL,
    "username" VARCHAR(50) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password_hash" VARCHAR(255) NOT NULL,
    "role" VARCHAR(20) NOT NULL DEFAULT 'user',
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "users" ADD PRIMARY KEY("id");
ALTER TABLE
    "users" ADD CONSTRAINT "users_username_unique" UNIQUE("username");
ALTER TABLE
    "users" ADD CONSTRAINT "users_email_unique" UNIQUE("email");
COMMENT
ON COLUMN
    "users"."role" IS 'CHECK IN (''user'', ''admin'')';
CREATE TABLE "poems"(
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "content" TEXT NOT NULL,
    "category_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "update_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "poems" ADD PRIMARY KEY("id");
ALTER TABLE
    "poems" ADD PRIMARY KEY("category_id");
CREATE TABLE "categories"(
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL
);
ALTER TABLE
    "categories" ADD PRIMARY KEY("id");
ALTER TABLE
    "categories" ADD CONSTRAINT "categories_name_unique" UNIQUE("name");
CREATE TABLE "comments"(
    "id" SERIAL NOT NULL,
    "content" TEXT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "poem_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "comments" ADD PRIMARY KEY("id");
CREATE TABLE "likes"(
    "id" SERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "poem_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "likes" ADD PRIMARY KEY("id");
ALTER TABLE
    "likes" ADD CONSTRAINT "likes_user_id_unique" UNIQUE("user_id");
ALTER TABLE
    "likes" ADD CONSTRAINT "likes_poem_id_unique" UNIQUE("poem_id");
ALTER TABLE
    "comments" ADD CONSTRAINT "comments_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "categories" ADD CONSTRAINT "categories_id_foreign" FOREIGN KEY("id") REFERENCES "poems"("category_id");
ALTER TABLE
    "likes" ADD CONSTRAINT "likes_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "comments" ADD CONSTRAINT "comments_poem_id_foreign" FOREIGN KEY("poem_id") REFERENCES "poems"("id");
ALTER TABLE
    "likes" ADD CONSTRAINT "likes_poem_id_foreign" FOREIGN KEY("poem_id") REFERENCES "poems"("id");