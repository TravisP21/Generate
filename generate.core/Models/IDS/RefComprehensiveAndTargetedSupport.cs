﻿using System.Collections.Generic;

namespace generate.core.Models.IDS
{
	public partial class RefComprehensiveAndTargetedSupport
	{
		public RefComprehensiveAndTargetedSupport()
		{
			K12schoolStatus = new HashSet<K12schoolStatus>();
		}

		public int RefComprehensiveAndTargetedSupportId { get; set; }
		public string Description { get; set; }
		public string Code { get; set; }
		public string Definition { get; set; }
		public int? RefJurisdictionId { get; set; }
		public decimal? SortOrder { get; set; }

		public virtual ICollection<K12schoolStatus> K12schoolStatus { get; set; }
		public virtual Organization RefJurisdiction { get; set; }
	}
}
