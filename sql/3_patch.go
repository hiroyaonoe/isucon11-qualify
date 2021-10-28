package main

import (
	"fmt"
	"os"
	"path/filepath"
	"time"

	"github.com/jmoiron/sqlx"
)

const (
	iconDirectoryPath = "../icon/"
)

type Isu struct {
	ID         int       `db:"id" json:"id"`
	JIAIsuUUID string    `db:"jia_isu_uuid" json:"jia_isu_uuid"`
	Name       string    `db:"name" json:"name"`
	Image      []byte    `db:"image" json:"-"`
	Character  string    `db:"character" json:"character"`
	JIAUserID  string    `db:"jia_user_id" json:"-"`
	CreatedAt  time.Time `db:"created_at" json:"-"`
	UpdatedAt  time.Time `db:"updated_at" json:"-"`
}

type MySQLConnectionEnv struct {
	Host     string
	Port     string
	User     string
	DBName   string
	Password string
}

func getEnv(key string, defaultValue string) string {
	val := os.Getenv(key)
	if val != "" {
		return val
	}
	return defaultValue
}

func NewMySQLConnectionEnv() *MySQLConnectionEnv {
	return &MySQLConnectionEnv{
		Host:     getEnv("MYSQL_HOST", "127.0.0.1"),
		Port:     getEnv("MYSQL_PORT", "3306"),
		User:     getEnv("MYSQL_USER", "isucon"),
		DBName:   getEnv("MYSQL_DBNAME", "isucondition"),
		Password: getEnv("MYSQL_PASS", "isucon"),
	}
}

func (mc *MySQLConnectionEnv) ConnectDB() (*sqlx.DB, error) {
	dsn := fmt.Sprintf("%v:%v@tcp(%v:%v)/%v?parseTime=true&loc=Asia%%2FTokyo", mc.User, mc.Password, mc.Host, mc.Port, mc.DBName)
	return sqlx.Open("mysql", dsn)
}

func main() {
	os.Exit(exec())
}

func exec() int {
	mySQLConnectionData := NewMySQLConnectionEnv()

	var err error
	db, err := mySQLConnectionData.ConnectDB()
	if err != nil {
		fmt.Printf("failed to connect db: %v", err)
		return 1
	}
	db.SetMaxOpenConns(10)
	defer db.Close()

	isus := []Isu{}
	err = db.Select(&isus, "SELECT * FROM `isu`")
	if err != nil {
		fmt.Printf("failed to exec query: %v", err)
		return 1
	}

	for _, isu := range isus {
		err = saveIcon(isu.JIAIsuUUID, isu.Image)
		if err != nil {
			fmt.Printf("failed to exec query: %v", err)
			return 1
		}
	}

	return 0
}

func saveIcon(jiaIsuUUID string, image []byte) error {
	iconFilePath := filepath.Join(iconDirectoryPath, jiaIsuUUID)
	f, err := os.Create(iconFilePath)
	defer f.Close()
	if err != nil {
		return fmt.Errorf("failed to saveIcon:%w", err)
	}

	_, err = f.Write(image)
	return err
}
