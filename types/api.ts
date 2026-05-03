/**
 * Types transversaux — couche API et services.
 * Tous les services retournent ServiceResult<T> — jamais de throw direct.
 */

export type ServiceResult<T> = {
  data: T | null;
  error: string | null;
};

export type PaginatedResult<T> = ServiceResult<{
  items: T[];
  count: number;
  hasMore: boolean;
}>;
