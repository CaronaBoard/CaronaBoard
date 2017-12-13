export const tuple = (a, b) => [a, b];

export const error = a => tuple(a, null);

export const success = b => tuple(null, b);
