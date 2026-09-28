-- ============================================================
-- OBA — MIGRATION 17: AI-11 Raw Ingestion Storage
-- Stage 1: Raw Ingestion Storage
-- Creates a table to store exactly what a source handed over —
-- raw rows, uninterpreted. Includes tags for source, arrival time,
-- and batch reference. Feeds AI-12 (Identity Resolution).
-- ============================================================

CREATE TABLE IF NOT EXISTS raw_ingestion_rows (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  source_name     TEXT NOT NULL,
  batch_reference TEXT NOT NULL,
  raw_data        JSONB NOT NULL,
  arrived_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  status          TEXT NOT NULL DEFAULT 'pending'
);

CREATE INDEX IF NOT EXISTS idx_raw_ingestion_rows_batch ON raw_ingestion_rows (batch_reference);
CREATE INDEX IF NOT EXISTS idx_raw_ingestion_rows_status ON raw_ingestion_rows (status);
