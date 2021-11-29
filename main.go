package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"rngrpc/echo"

	"google.golang.org/grpc"
)

func main() {
	lis, err := net.Listen("tcp", "172.20.10.3:1203")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	var opts []grpc.ServerOption

	grpcServer := grpc.NewServer(opts...)
	echo.RegisterEchoServiceServer(grpcServer, &EchoService{})
	grpcServer.Serve(lis)
}

type EchoService struct {
	echo.UnimplementedEchoServiceServer
}

// MessageCount var
var MessageCount int32 = 0

func (e *EchoService) Echo(ctx context.Context, in *echo.EchoRequest) (*echo.EchoResponse, error) {
	MessageCount++
	fmt.Println("Message Count: ", MessageCount, in.Message)
	return &echo.EchoResponse{
		Message:      in.Message,
		MessageCount: (MessageCount),
	}, nil
}
