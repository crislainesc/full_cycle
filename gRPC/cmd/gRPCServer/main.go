package main

import (
	"database/sql"
	"net"

	"github.com/crislainesc/full_cycle/gRPC/internal/database"
	"github.com/crislainesc/full_cycle/gRPC/internal/pb"
	"github.com/crislainesc/full_cycle/gRPC/internal/service"
	_ "github.com/mattn/go-sqlite3"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	db, err := sql.Open("sqlite3", "./db.sqlite")
	if err != nil {
		panic(err)
	}
	defer db.Close()

	categoryDB := database.NewCategory(db)
	categoryService := service.NewCategoryService(*categoryDB)

	gRPCServer := grpc.NewServer()
	pb.RegisterCategoryServiceServer(gRPCServer, categoryService)
	reflection.Register(gRPCServer)

	listener, err := net.Listen("tcp", ":50051")
	if err != nil {
		panic(err)
	}

	if err := gRPCServer.Serve(listener); err != nil {
		panic(err)
	}
}
