<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20220425114421 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE households (id SERIAL NOT NULL, referral VARCHAR(32) DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE TABLE images (id SERIAL NOT NULL, original_url VARCHAR(2048) NOT NULL, thumbnail_url VARCHAR(2048) DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE TABLE inventories (id SERIAL NOT NULL, product_id INT NOT NULL, household_id INT NOT NULL, stock DOUBLE PRECISION NOT NULL, unit VARCHAR(255) NOT NULL, expiration_date DATE DEFAULT NULL, freezer BOOLEAN NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_936C863D4584665A ON inventories (product_id)');
        $this->addSql('CREATE INDEX IDX_936C863DE79FF843 ON inventories (household_id)');
        $this->addSql('CREATE TABLE products (id SERIAL NOT NULL, image_id INT DEFAULT NULL, name VARCHAR(255) NOT NULL, description TEXT NOT NULL, type VARCHAR(255) NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_B3BA5A5A3DA5256D ON products (image_id)');
        $this->addSql('CREATE TABLE users (id SERIAL NOT NULL, household_id INT DEFAULT NULL, email VARCHAR(180) NOT NULL, roles JSON NOT NULL, password VARCHAR(255) NOT NULL, display_name VARCHAR(255) NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_1483A5E9E7927C74 ON users (email)');
        $this->addSql('CREATE INDEX IDX_1483A5E9E79FF843 ON users (household_id)');
        $this->addSql('ALTER TABLE inventories ADD CONSTRAINT FK_936C863D4584665A FOREIGN KEY (product_id) REFERENCES products (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE inventories ADD CONSTRAINT FK_936C863DE79FF843 FOREIGN KEY (household_id) REFERENCES households (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE products ADD CONSTRAINT FK_B3BA5A5A3DA5256D FOREIGN KEY (image_id) REFERENCES images (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE users ADD CONSTRAINT FK_1483A5E9E79FF843 FOREIGN KEY (household_id) REFERENCES households (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql("ALTER TABLE products ADD CONSTRAINT type_check CHECK (type IN ('short-term', 'long-term', 'expires', 'non-food'));");
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE inventories DROP CONSTRAINT FK_936C863DE79FF843');
        $this->addSql('ALTER TABLE users DROP CONSTRAINT FK_1483A5E9E79FF843');
        $this->addSql('ALTER TABLE products DROP CONSTRAINT FK_B3BA5A5A3DA5256D');
        $this->addSql('ALTER TABLE inventories DROP CONSTRAINT FK_936C863D4584665A');
        $this->addSql('ALTER TABLE products DROP CONSTRAINT type_check;');
        $this->addSql('DROP TABLE households');
        $this->addSql('DROP TABLE images');
        $this->addSql('DROP TABLE inventories');
        $this->addSql('DROP TABLE products');
        $this->addSql('DROP TABLE users');
    }
}
