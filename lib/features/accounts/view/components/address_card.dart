import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../../model/address_model.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onSetDefault;

  const AddressCard({
    super.key,
    required this.address,
    this.onEdit,
    this.onDelete,
    this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.blue_eef1ed,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: address.isDefault ? AppColors.black : Colors.grey.shade300,
          width: 1,
        ),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name + Type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    address.type.toUpperCase(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Address
            Text("${address.addressLine1}, ${address.addressLine2}"),
            Text(address.city),
            Text(
              address.pinCode,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 12),

            // Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                  onPressed: onDelete,
                ),
                if (!address.isDefault && onSetDefault != null)
                  IconButton(
                    icon: const Icon(Icons.star_border, size: 20),
                    onPressed: onSetDefault,
                  ),
                if (address.isDefault)
                  const Icon(Icons.star, size: 20, color: Colors.amber),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
