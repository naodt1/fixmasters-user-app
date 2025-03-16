import 'package:fixmasters_user_app/model/handyman_model.dart';
import 'package:fixmasters_user_app/view/widgets/availabilityChip.dart';
import 'package:flutter/material.dart';

class ServiceProvidersCard extends StatelessWidget {
  final HandymanModel serviceProviderModel;
  final VoidCallback onTap;

  const ServiceProvidersCard({Key? key, required this.serviceProviderModel, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundImage: NetworkImage(serviceProviderModel.profilePic),
        ),
        title: Text(serviceProviderModel.fullname),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${serviceProviderModel.gigs.first.gigName}', style: Theme.of(context).textTheme.bodySmall,), // Display category name
            SizedBox(height: 2),
            Row(
              children: [
                Icon(Icons.location_pin, size: 16, color: Theme.of(context).colorScheme.onBackground,),
                Text(serviceProviderModel.location, style: Theme.of(context).textTheme.labelMedium,)
              ],
            ),
            SizedBox(height: 4),
          ],
        ),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16,),
                  SizedBox(width: 4),
                   Text(serviceProviderModel.avgRating.toString() ?? '0.0'), // Display rating
                ],
              ),

              // AvailabilityChip(isAvailable: true)
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
