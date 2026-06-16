package main

import (
	"github.com/pulumi/pulumi-equinix/sdk/v2/go/equinix/metal"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi/config"
)

func main() {
	pulumi.Run(func(ctx *pulumi.Context) error {
		cfg := config.New(ctx, "")
		plan := cfg.Require("plan")
		facility := cfg.Require("facility")
		os := cfg.Require("os")

		// Provision bare-metal compute optimized for low-latency kernel workloads
		masterNode, err := metal.NewDevice(ctx, "talos-master-node", &metal.DeviceArgs{
			Hostname:        pulumi.String("infra-master-01"),
			Plan:            pulumi.String(plan),
			Facilities:      pulumi.StringArray{pulumi.String(facility)},
			OperatingSystem: pulumi.String(os),
			BillingCycle:    pulumi.String("hourly"),
			ProjectId:       pulumi.String("bf93b51a-d021-4f36-be8d-71b312782e3b"),
		})
		if err != nil {
			return err
		}

		ctx.Export("masterNodeIP", masterNode.AccessPublicIpv4)
		return nil
	})
}
