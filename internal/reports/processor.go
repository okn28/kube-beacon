package reports

import (
	"github.com/chen-keinan/beacon/internal/logger"
	"github.com/chen-keinan/beacon/internal/models"
	"github.com/gosuri/uitable"
)

var log = logger.GetLog()

//GenerateAuditReport generate failed audit report
func GenerateAuditReport(adtsReport []*models.AuditBench) {
	table := uitable.New()
	for _, failedAudit := range adtsReport {
		table.MaxColWidth = 100
		table.Wrap = true // wrap columns
		table.AddRow("--------------", "-------------------------------------------------------------------------------------------")
		table.AddRow("Name:", failedAudit.Name)
		table.AddRow("Description:", failedAudit.Description)
		table.AddRow("Impact:", failedAudit.Impact)
		table.AddRow("Remediation:", failedAudit.Remediation)
		table.AddRow("References:", failedAudit.References)
		table.AddRow("") // blank
	}
	log.Table(table)
}
