import { SchemaDirectiveVisitor } from '@graphql-tools/utils';
import { defaultFieldResolver } from 'graphql';

class RequiresRoleDirective extends SchemaDirectiveVisitor {
    visitFieldDefinition(field) {
        const requiredRole = this.args.role;
        const originalResolver = field.resolve || defaultFieldResolver;

        field.resolve = async function (...args) {
            const context = args[2];
            const roles = context?.user?.roles || [];

            if (!roles.includes(requiredRole)) {
                throw new Error(`Access denied. Requires role: ${requiredRole}`);
            }

            return originalResolver.apply(this, args);
        };
    }
}
