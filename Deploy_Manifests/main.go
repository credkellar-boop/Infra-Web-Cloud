package main

import (
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi"
)

func main() {
	pulumi.Run(func(ctx *pulumi.Context) error {
		// Provision bare-metal nodes and hook up Cilium network topologies here
		return nil
	})
}
